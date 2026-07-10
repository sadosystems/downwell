// downwell_rs app: wgpu platform layer, two frontends.
//
// Windowed (default, geist/libTAS path): SDL2 window 760x568; wgpu renders
// offscreen, the finished frame is blitted via SDL's software renderer.
// SDL present + SDL keyboard are libTAS's best-hooked paths, so the binary
// runs under the exact same harness as the GM runner: same virtual clock,
// same injected inputs, same swap-triggered capture.
//
// Headless (--out PATH): render N frames and append raw RGB24 to a file
// (geist's capture format). Fast inner-loop dev tool only — verification
// goes through geist on the two binaries directly.
mod atlas_gen;

use std::io::Write;

const WIN_W: u32 = 760;
const WIN_H: u32 = 568;
// GUI units -> window px: scale 2, app surface centered (port 320px @ x=220)
const GUI_SCALE: f32 = 2.0;
const GUI_OFF_X: f32 = 220.0;
// wgpu requires bytes_per_row % 256 == 0: 760*4 = 3040 -> 3072
const PAD_ROW: u32 = 3072;

#[repr(C)]
#[derive(Clone, Copy)]
struct Inst {
    rect: [f32; 4],
    uv: [f32; 4],
    color: [f32; 4],
    extra: [f32; 4],
}

struct Gpu {
    device: wgpu::Device,
    queue: wgpu::Queue,
    target: wgpu::Texture,
    target_view: wgpu::TextureView,
    readback: wgpu::Buffer,
    pipeline: wgpu::RenderPipeline,
    bind_group: wgpu::BindGroup,
    inst_buf: wgpu::Buffer,
    insts: Vec<Inst>,
}

// elapsed monotonic microseconds — libTAS virtualizes this clock, so under
// geist both binaries read the harness-controlled value (GM's randomize source)
fn elapsed_us() -> u64 {
    let mut ts = std::mem::MaybeUninit::<libc::timespec>::uninit();
    unsafe {
        libc::clock_gettime(libc::CLOCK_MONOTONIC, ts.as_mut_ptr());
        let ts = ts.assume_init();
        ts.tv_sec as u64 * 1_000_000 + ts.tv_nsec as u64 / 1_000
    }
}

fn main() {
    // read the randomize() clock FIRST — before SDL/wgpu init can advance
    // libTAS's virtual time — and stash it for boot()
    let boot_us = elapsed_us();
    if std::env::var("DOWNWELL_SEED_LOG").is_ok() {
        let lo = boot_us as u32;
        eprintln!(
            "[seed] elapsed_us={} seed={:#010x}",
            boot_us,
            lo.rotate_left(16) ^ lo.wrapping_add((boot_us >> 32) as u32)
        );
    }
    // single-threaded software rasterization: llvmpipe/lavapipe worker threads
    // confuse libTAS's frame gating (irregular input staging). Must be set
    // before the driver initializes.
    std::env::set_var("LP_NUM_THREADS", "0");
    let mut frames: u32 = 799;
    let mut out: Option<String> = None;
    let mut driven = false;
    let mut args = std::env::args().skip(1);
    while let Some(a) = args.next() {
        match a.as_str() {
            "--frames" => frames = args.next().unwrap().parse().unwrap(),
            "--out" => out = Some(args.next().unwrap()),
            "--drive" => driven = true,
            "-game" => {
                args.next(); // GM runner compatibility: ignore the data file
            }
            _ => panic!("unknown arg {a}"),
        }
    }
    let mut gpu = pollster::block_on(Gpu::new());
    match out {
        Some(path) => headless(&mut gpu, frames, &path, driven, boot_us),
        None => windowed(&mut gpu, boot_us),
    }
}

// drive_welltaro.lua tape: SPACE 4-on/36-off before f 780, 3-on/15-off after;
// D at [820,855)+[930,960), A at [880,910)+[990,1015)
// DOWNWELL_TAPE_FILE: per-frame tape from a converted .ltm (ltm2tape.py):
// one line per movie frame, chars S/L/R (space/left/right), '-' = none
fn load_tape_file() -> Option<Vec<sim::Input>> {
    let path = std::env::var("DOWNWELL_TAPE_FILE").ok()?;
    let text = std::fs::read_to_string(path).ok()?;
    Some(
        text.lines()
            .map(|l| sim::Input {
                space: l.contains('S'),
                left: l.contains('L'),
                right: l.contains('R'),
            })
            .collect(),
    )
}

fn tape(f: u32, enabled: bool) -> sim::Input {
    if !enabled {
        return sim::Input::default();
    }
    // DOWNWELL_TAPE selects the schedule: "right_walk" = righ_walk.lua
    // (D held from f850, nothing else); any other value = drive_welltaro.lua
    if std::env::var("DOWNWELL_TAPE")
        .map(|v| v.contains("right"))
        .unwrap_or(false)
    {
        return sim::Input {
            space: false,
            left: false,
            right: f >= 850,
        };
    }
    let space = if f < 780 { f % 40 < 4 } else { f % 18 < 3 };
    let win = |lo: u32, hi: u32| f >= lo && f < hi;
    sim::Input {
        space,
        left: win(880, 910) || win(990, 1015),
        right: win(820, 855) || win(930, 960),
    }
}

fn headless(gpu: &mut Gpu, frames: u32, out_path: &str, driven: bool, boot_us: u64) {
    let sim_log = std::env::var("DOWNWELL_SIM_LOG").is_ok();
    let mut gs = sim::GameState::new();
    gs.boot(boot_us);
    let mut dl = Box::new(sim::DrawList::EMPTY);
    let mut rgb = vec![0u8; (WIN_W * WIN_H * 3) as usize];
    let mut file = std::io::BufWriter::new(std::fs::File::create(out_path).unwrap());
    for f in 0..frames {
        // align with windowed tape mode: input(tick) = tape(tick+2)
        let prev_stammo = gs.pl.stammo;
        sim::tick(&mut gs, tape(f + 2, driven));
        if sim_log && gs.pl.stammo != prev_stammo {
            let casings = gs.fx.iter().filter(|x| x.alive && x.kind == 2).count();
            eprintln!(
                "[ammo] t={} stammo {}->{} casings_alive={}",
                f, prev_stammo, gs.pl.stammo, casings
            );
        }
        if sim_log && (350..=380).contains(&f) {
            eprintln!(
                "[sim] t={} ysp={:.20} yy={:.6} grounded={} spr={} idx={:.2} lock={} sd={}",
                f,
                gs.pl.ysp,
                gs.pl.yy,
                gs.pl.grounded as u8,
                gs.pl.sprite_index,
                gs.pl.image_index,
                gs.pl.jump_shoot_lock as u8,
                gs.pl.shot_delay as u8
            );
        }
        sim::draw(&mut gs, &mut dl);
        gpu.render(&dl, &mut rgb);
        file.write_all(&rgb).unwrap();
    }
    file.flush().unwrap();
    eprintln!("[downwell_rs] wrote {frames} frames to {out_path}");
}

fn windowed(gpu: &mut Gpu, boot_us: u64) {
    // Standalone runs pace themselves to 60 FPS; under libTAS the harness
    // gates every present (and virtualizes the clock), so pacing is skipped.
    let under_libtas = std::env::var("LD_PRELOAD")
        .map(|v| v.to_lowercase().contains("libtas"))
        .unwrap_or(false);
    let frame_dt = std::time::Duration::from_nanos(1_000_000_000 / 60);
    let mut next_frame = std::time::Instant::now() + frame_dt;

    let sdl = sdl2::init().unwrap();
    let video = sdl.video().unwrap();
    // Mimic the GM runner's boot: window starts 320x568, presents, then a
    // graphics reset resizes to 760x568 — libTAS segments its encode at the
    // re-init, which shifts the step<->capture<->input alignment. Doing the
    // same dance keeps both binaries on identical harness timing.
    let window = video
        .window("downwell_rs", 320, WIN_H)
        .position_centered()
        .build()
        .unwrap();
    // software renderer: presentation is a plain blit libTAS can hook & capture
    let mut canvas = window.into_canvas().software().build().unwrap();
    canvas.set_draw_color(sdl2::pixels::Color::RGB(0, 0, 0));
    canvas.clear();
    canvas.present(); // boot present at 320x568 (GM presents before its reset)
    canvas.window_mut().set_size(WIN_W, WIN_H).unwrap();
    let texc = canvas.texture_creator();
    let mut tex = texc
        .create_texture_streaming(sdl2::pixels::PixelFormatEnum::RGB24, WIN_W, WIN_H)
        .unwrap();
    let mut pump = sdl.event_pump().unwrap();

    let input_log = std::env::var("DOWNWELL_INPUT_LOG").is_ok();
    // Input keyed to logical ticks (geist agent_log's prescribed fix for
    // cross-engine input desync): compute the drive tape from our own tick
    // counter instead of relying on libTAS's frame-keyed SDL injection.
    let tape_mode = std::env::var("DOWNWELL_TAPE").is_ok();
    let tape_file = load_tape_file(); // takes precedence over DOWNWELL_TAPE
    let mut tick_no: u64 = 0;
    let mut gs = sim::GameState::new();
    gs.boot(boot_us);
    let mut dl = Box::new(sim::DrawList::EMPTY);
    let mut rgb = vec![0u8; (WIN_W * WIN_H * 3) as usize];
    // track held keys from SDL key events (libTAS delivers these on the same
    // schedule as the X11 events GM consumes; the keyboard-state array lags)
    let (mut k_space, mut k_left, mut k_right) = (false, false, false);

    // GM's boot presents one extra black frame into the post-reset segment
    // when key events arrive during boot (event-loop iteration); mirror that
    // condition so idle and driven tapes both align.
    let boot_saw_key;
    {
        let mut saw_key = false;
        for e in pump.poll_iter() {
            use sdl2::event::Event;
            use sdl2::keyboard::Scancode;
            match e {
                Event::KeyDown {
                    scancode: Some(sc), ..
                } => {
                    saw_key = true;
                    match sc {
                        Scancode::Space => k_space = true,
                        Scancode::A => k_left = true,
                        Scancode::D => k_right = true,
                        _ => {}
                    }
                }
                Event::KeyUp { .. } => saw_key = true,
                _ => {}
            }
        }
        if saw_key {
            canvas.set_draw_color(sdl2::pixels::Color::RGB(0, 0, 0));
            canvas.clear();
            canvas.present(); // driven-style extra boot present
        }
        boot_saw_key = saw_key;
    }

    'run: loop {
        use sdl2::event::Event;
        use sdl2::keyboard::Scancode;
        for e in pump.poll_iter() {
            if let Event::Quit { .. } = e {
                break 'run;
            }
        }
        let input = if let Some(t) = &tape_file {
            let idx = tick_no as usize + if boot_saw_key { 2 } else { 1 };
            t.get(idx).copied().unwrap_or_default()
        } else if tape_mode {
            // same schedule the lua injects into GM, keyed to our ticks.
            // GM's X11 KeyUp lands one frame before the staged schedule ends:
            // AND consecutive frames to shorten each hold's tail by one
            // (press edges unchanged; verified via the jump-apex ysp halving).
            // capture alignment depends on the extra boot present (only
            // emitted when boot saw key events): offset 2 with it, 1 without
            tape(tick_no as u32 + if boot_saw_key { 2 } else { 1 }, true)
        } else {
            // read the keyboard STATE (post-pump)
            let ks = pump.keyboard_state();
            sim::Input {
                space: ks.is_scancode_pressed(Scancode::Space),
                left: ks.is_scancode_pressed(Scancode::A),
                right: ks.is_scancode_pressed(Scancode::D),
            }
        };
        let _ = (&k_space, &k_left, &k_right);

        if input_log && (input.space || input.left || input.right) {
            eprintln!(
                "[in] tick={} sp={} l={} r={}",
                tick_no, input.space as u8, input.left as u8, input.right as u8
            );
        }
        tick_no += 1;
        sim::tick(&mut gs, input);
        sim::draw(&mut gs, &mut dl);
        gpu.render(&dl, &mut rgb);

        tex.update(None, &rgb, (WIN_W * 3) as usize).unwrap();
        canvas.copy(&tex, None, None).unwrap();
        canvas.present(); // libTAS frame boundary

        if !under_libtas {
            let now = std::time::Instant::now();
            if next_frame > now {
                std::thread::sleep(next_frame - now);
            }
            next_frame += frame_dt;
            // don't accumulate debt after long stalls (window drag etc.)
            if next_frame < std::time::Instant::now() {
                next_frame = std::time::Instant::now() + frame_dt;
            }
        }
    }
}

impl Gpu {
    async fn new() -> Gpu {
        let instance = wgpu::Instance::new(wgpu::InstanceDescriptor::default());
        let adapter = instance
            .request_adapter(&wgpu::RequestAdapterOptions {
                power_preference: wgpu::PowerPreference::HighPerformance,
                compatible_surface: None,
                force_fallback_adapter: false,
            })
            .await
            .expect("no adapter");
        let (device, queue) = adapter
            .request_device(&wgpu::DeviceDescriptor::default(), None)
            .await
            .expect("no device");

        // atlas
        let atlas_bytes: &[u8] = include_bytes!("../../assets/atlas.rgba");
        let atlas_size = wgpu::Extent3d {
            width: atlas_gen::ATLAS_W,
            height: atlas_gen::ATLAS_H,
            depth_or_array_layers: 1,
        };
        let atlas = device.create_texture(&wgpu::TextureDescriptor {
            label: Some("atlas"),
            size: atlas_size,
            mip_level_count: 1,
            sample_count: 1,
            dimension: wgpu::TextureDimension::D2,
            format: wgpu::TextureFormat::Rgba8Unorm,
            usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
            view_formats: &[],
        });
        queue.write_texture(
            wgpu::ImageCopyTexture {
                texture: &atlas,
                mip_level: 0,
                origin: wgpu::Origin3d::ZERO,
                aspect: wgpu::TextureAspect::All,
            },
            atlas_bytes,
            wgpu::ImageDataLayout {
                offset: 0,
                bytes_per_row: Some(atlas_gen::ATLAS_W * 4),
                rows_per_image: Some(atlas_gen::ATLAS_H),
            },
            atlas_size,
        );

        let target = device.create_texture(&wgpu::TextureDescriptor {
            label: Some("target"),
            size: wgpu::Extent3d {
                width: WIN_W,
                height: WIN_H,
                depth_or_array_layers: 1,
            },
            mip_level_count: 1,
            sample_count: 1,
            dimension: wgpu::TextureDimension::D2,
            format: wgpu::TextureFormat::Rgba8Unorm,
            usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
            view_formats: &[],
        });
        let target_view = target.create_view(&wgpu::TextureViewDescriptor::default());
        let readback = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("readback"),
            size: (PAD_ROW * WIN_H) as u64,
            usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
            mapped_at_creation: false,
        });

        let shader = device.create_shader_module(wgpu::include_wgsl!("shader.wgsl"));
        let sampler = device.create_sampler(&wgpu::SamplerDescriptor {
            mag_filter: wgpu::FilterMode::Nearest,
            min_filter: wgpu::FilterMode::Nearest,
            ..Default::default()
        });
        let bgl = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
            label: None,
            entries: &[
                wgpu::BindGroupLayoutEntry {
                    binding: 0,
                    visibility: wgpu::ShaderStages::FRAGMENT,
                    ty: wgpu::BindingType::Texture {
                        sample_type: wgpu::TextureSampleType::Float { filterable: true },
                        view_dimension: wgpu::TextureViewDimension::D2,
                        multisampled: false,
                    },
                    count: None,
                },
                wgpu::BindGroupLayoutEntry {
                    binding: 1,
                    visibility: wgpu::ShaderStages::FRAGMENT,
                    ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
                    count: None,
                },
            ],
        });
        let bind_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
            label: None,
            layout: &bgl,
            entries: &[
                wgpu::BindGroupEntry {
                    binding: 0,
                    resource: wgpu::BindingResource::TextureView(
                        &atlas.create_view(&wgpu::TextureViewDescriptor::default()),
                    ),
                },
                wgpu::BindGroupEntry {
                    binding: 1,
                    resource: wgpu::BindingResource::Sampler(&sampler),
                },
            ],
        });
        let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
            label: None,
            bind_group_layouts: &[&bgl],
            push_constant_ranges: &[],
        });
        let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
            label: None,
            layout: Some(&layout),
            vertex: wgpu::VertexState {
                module: &shader,
                entry_point: "vs_main",
                compilation_options: Default::default(),
                buffers: &[wgpu::VertexBufferLayout {
                    array_stride: core::mem::size_of::<Inst>() as u64,
                    step_mode: wgpu::VertexStepMode::Instance,
                    attributes: &wgpu::vertex_attr_array![0 => Float32x4, 1 => Float32x4, 2 => Float32x4, 3 => Float32x4],
                }],
            },
            fragment: Some(wgpu::FragmentState {
                module: &shader,
                entry_point: "fs_main",
                compilation_options: Default::default(),
                targets: &[Some(wgpu::ColorTargetState {
                    format: wgpu::TextureFormat::Rgba8Unorm,
                    blend: Some(wgpu::BlendState::ALPHA_BLENDING),
                    write_mask: wgpu::ColorWrites::ALL,
                })],
            }),
            primitive: wgpu::PrimitiveState::default(),
            depth_stencil: None,
            multisample: wgpu::MultisampleState::default(),
            multiview: None,
            cache: None,
        });

        let inst_buf = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("instances"),
            size: (sim::MAX_DRAW * core::mem::size_of::<Inst>()) as u64,
            usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
            mapped_at_creation: false,
        });
        let insts = vec![
            Inst {
                rect: [0.0; 4],
                uv: [0.0; 4],
                color: [0.0; 4],
                extra: [0.0; 4]
            };
            sim::MAX_DRAW
        ];

        Gpu {
            device,
            queue,
            target,
            target_view,
            readback,
            pipeline,
            bind_group,
            inst_buf,
            insts,
        }
    }

    // render the draw list and read the frame back as RGB24 rows
    fn render(&mut self, dl: &sim::DrawList, rgb_out: &mut [u8]) {
        let n = dl.n;
        for i in 0..n {
            let c = &dl.cmds[i];
            let (rx, ry, rw, rh) = atlas_gen::sprite_rect(c.sprite, c.frame);
            let flip = c.w < 0.0;
            let (gx, gw) = if flip { (c.x + c.w, -c.w) } else { (c.x, c.w) };
            let (u0, u1) = if flip {
                ((rx + rw) as f32, rx as f32)
            } else {
                (rx as f32, (rx + rw) as f32)
            };
            let flipv = c.h < 0.0;
            let (gy, gh) = if flipv { (c.y + c.h, -c.h) } else { (c.y, c.h) };
            let (v0, v1) = if flipv {
                ((ry + rh) as f32, ry as f32)
            } else {
                (ry as f32, (ry + rh) as f32)
            };
            self.insts[i] = Inst {
                rect: [
                    gx * GUI_SCALE + GUI_OFF_X,
                    gy * GUI_SCALE,
                    gw * GUI_SCALE,
                    gh * GUI_SCALE,
                ],
                uv: [
                    u0 / atlas_gen::ATLAS_W as f32,
                    v0 / atlas_gen::ATLAS_H as f32,
                    u1 / atlas_gen::ATLAS_W as f32,
                    v1 / atlas_gen::ATLAS_H as f32,
                ],
                color: [
                    ((c.color >> 24) & 0xFF) as f32 / 255.0,
                    ((c.color >> 16) & 0xFF) as f32 / 255.0,
                    ((c.color >> 8) & 0xFF) as f32 / 255.0,
                    (c.color & 0xFF) as f32 / 255.0,
                ],
                extra: [c.pal as f32, c.rot.to_radians(), 0.0, 0.0],
            };
        }
        if n > 0 {
            let bytes = unsafe {
                core::slice::from_raw_parts(
                    self.insts.as_ptr() as *const u8,
                    n * core::mem::size_of::<Inst>(),
                )
            };
            self.queue.write_buffer(&self.inst_buf, 0, bytes);
        }

        let mut enc = self
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor::default());
        {
            let mut rp = enc.begin_render_pass(&wgpu::RenderPassDescriptor {
                label: None,
                color_attachments: &[Some(wgpu::RenderPassColorAttachment {
                    view: &self.target_view,
                    resolve_target: None,
                    ops: wgpu::Operations {
                        load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
                        store: wgpu::StoreOp::Store,
                    },
                })],
                depth_stencil_attachment: None,
                timestamp_writes: None,
                occlusion_query_set: None,
            });
            rp.set_pipeline(&self.pipeline);
            rp.set_bind_group(0, &self.bind_group, &[]);
            rp.set_vertex_buffer(0, self.inst_buf.slice(..));
            if n > 0 {
                rp.draw(0..6, 0..n as u32);
            }
        }
        enc.copy_texture_to_buffer(
            wgpu::ImageCopyTexture {
                texture: &self.target,
                mip_level: 0,
                origin: wgpu::Origin3d::ZERO,
                aspect: wgpu::TextureAspect::All,
            },
            wgpu::ImageCopyBuffer {
                buffer: &self.readback,
                layout: wgpu::ImageDataLayout {
                    offset: 0,
                    bytes_per_row: Some(PAD_ROW),
                    rows_per_image: Some(WIN_H),
                },
            },
            wgpu::Extent3d {
                width: WIN_W,
                height: WIN_H,
                depth_or_array_layers: 1,
            },
        );
        self.queue.submit([enc.finish()]);

        let slice = self.readback.slice(..);
        let done = std::sync::Arc::new(std::sync::atomic::AtomicBool::new(false));
        let done2 = done.clone();
        slice.map_async(wgpu::MapMode::Read, move |r| {
            r.unwrap();
            done2.store(true, std::sync::atomic::Ordering::Release);
        });
        // busy-poll: no timed waits between presents (libTAS advances its
        // frame counter on timed waits, which slips input staging)
        while !done.load(std::sync::atomic::Ordering::Acquire) {
            self.device.poll(wgpu::Maintain::Poll);
        }
        {
            let data = slice.get_mapped_range();
            for row in 0..WIN_H as usize {
                let src = &data[row * PAD_ROW as usize..];
                let dst = &mut rgb_out[row * WIN_W as usize * 3..];
                for x in 0..WIN_W as usize {
                    dst[x * 3] = src[x * 4];
                    dst[x * 3 + 1] = src[x * 4 + 1];
                    dst[x * 3 + 2] = src[x * 4 + 2];
                }
            }
        }
        self.readback.unmap();
    }
}
