// downwell_rs sim: pure deterministic game logic. No deps, no alloc, POD state.
// GM semantics replicated exactly; timing verified against libTAS captures.
#![no_std]

mod sprites_gen;
pub use sprites_gen::*;
mod hud;
mod menu;
pub mod player;
pub mod rng;
mod room_menu_gen;

// GUI coordinate space: 160x284 units, origin at app-surface top-left.
// Window = 760x568 px: gui*2 + (220,0). Visible GUI x range: -110..270.
pub const GUI_XMIN: i32 = -110;
pub const GUI_XMAX: i32 = 270;
pub const GUI_H: i32 = 284;

// sprites are GM asset ids (from gmdata/game.unx); two synthetic ids:
pub mod spr {
    pub const RECT: u16 = 998; // solid fill
    pub const FONT0: u16 = 999; // frame = ascii code
    pub const PLAYER_NAP: u16 = 11;
    pub const PLAYER_IDLE: u16 = 31;
    pub const NEW_HUD_GAUGE: u16 = 373;
    pub const HUD_CURRENCY: u16 = 376;
    pub const HP_GAUGE_BAR: u16 = 378;
    pub const RED_PIXEL: u16 = 383;
    pub const TABLET_BORDER: u16 = 408;
    pub const SPRITE_NUMBER: u16 = 413;
    pub const SPRITE_SLASH: u16 = 414;
    pub const PC_HUD_HP_GAUGE: u16 = 415;
    pub const STAMMO_GAUGE: u16 = 416;
    pub const STAMMO_POP: u16 = 418;
    pub const STAMMO_CHARGE: u16 = 419;
    pub const STAMMO_DIVIDE: u16 = 421;
    pub const PIXEL: u16 = 422;
    pub const DOT: u16 = 590;
    pub const CONTROLS: u16 = 695;
    pub const DEVOLVER: u16 = 696;
    pub const DITHER: u16 = 733;
}

pub const C_BLACK: u32 = 0x0000_00FF;
pub const C_WHITE: u32 = 0xFFFF_FFFF;
pub const C_RED: u32 = 0xFF00_00FF;

pub const MAX_DRAW: usize = 4096;

#[repr(C)]
#[derive(Clone, Copy)]
pub struct DrawCmd {
    pub sprite: u16,
    pub frame: u16,
    // top-left in GUI units (origin already applied); w<0 / h<0 = flipped
    pub x: f32,
    pub y: f32,
    pub w: f32,
    pub h: f32,
    pub color: u32, // 0xRRGGBBAA tint
    pub pal: u32,   // 1 = inside GM shader block (DOWNWELL palette shader)
    pub rot: f32,   // image_angle degrees CCW (GM), rotates around quad center
}

#[repr(C)]
pub struct DrawList {
    pub n: usize,
    pub cmds: [DrawCmd; MAX_DRAW],
}

impl DrawList {
    pub const EMPTY: DrawList = DrawList {
        n: 0,
        cmds: [DrawCmd {
            sprite: 0,
            frame: 0,
            x: 0.0,
            y: 0.0,
            w: 0.0,
            h: 0.0,
            color: 0,
            pal: 0,
            rot: 0.0,
        }; MAX_DRAW],
    };
    pub fn clear(&mut self) {
        self.n = 0;
    }
    pub(crate) fn push(&mut self, c: DrawCmd) {
        if self.n < MAX_DRAW {
            self.cmds[self.n] = c;
            self.n += 1;
        }
    }
}

#[derive(Clone, Copy, Default)]
pub struct Input {
    pub space: bool,
    pub left: bool,
    pub right: bool,
}

#[derive(Clone, Copy, PartialEq)]
pub enum Room {
    Init,
    Menu,
}

#[repr(C)]
pub struct GameState {
    pub frame: u32,
    pub room: Room,
    pub room_frame: u32, // frames since current room started
    pub prev_space: bool,
    pub d_up: bool,
    // obj_init_rm
    pub room_dest_set: bool,
    pub alarm0: i32, // GM alarm: -1 = off, fires when decrement reaches 0
    // globals
    pub show_splash: i32,
    pub splash_dith_frame: f64, // GM reals are doubles
    // ditherFade instance (rmMenu dissolve): image_index/image_speed
    pub fade_alarm: i32,
    // ditherFade image_index/image_speed: f32 engine fields (see menu.rs)
    pub fade_index: f32,
    pub fade_speed: f32,
    pub fade_alive: bool,
    pub rng: rng::GmRng,
    pub scene: menu::MenuScene,
    pub inputs: player::Inputs,
    pub pl: player::Player,
    pub cam: player::Camera,
    pub fx: [player::Fx; player::FX_MAX],
    pub bullets: [player::Bullet; player::BUL_MAX],
    pub meter_jiggle: f64,
    pub hud: hud::HudState,
    // objTitle (328, ystart 432), sprite 654 sprTitleFade 10 frames
    pub title_idx: f32,
    pub title_speed: f32,
    pub title_y: f64,
    pub title_first: bool,
    pub title_bong: bool,
    pub title_alarm0: i32,
    pub title_alarm1: i32,
    pub title_alarm2: i32,
    // objBgNightsky position, set in its Step from LAST frame's view
    pub sky_x: i32,
    pub sky_y: i32,
    pub fx_seq: u32,
    pub no_control: bool,
    // GM's room switch consumes an extra present; menu-phase constants are
    // capture-aligned (calibrated vs idle captures), so menu inputs must be
    // delayed one frame to stay aligned with them.
    pub raw_prev: Input,
}

impl GameState {
    pub const fn new() -> GameState {
        GameState {
            frame: 0,
            room: Room::Init,
            room_frame: 0,
            prev_space: false,
            d_up: false,
            room_dest_set: false,
            alarm0: -1,
            show_splash: 1, // obj_controler_n Create: isPC -> showSplash = 1
            splash_dith_frame: 0.0,
            fade_alarm: -1,
            fade_index: 0.0,
            fade_speed: 0.0,
            fade_alive: false,
            rng: rng::GmRng::zeroed(),
            scene: menu::MenuScene::zeroed(),
            inputs: player::Inputs::zeroed(),
            pl: player::Player::zeroed(),
            cam: player::Camera::zeroed(),
            fx: [player::Fx::zeroed(); player::FX_MAX],
            bullets: [player::Bullet::zeroed(); player::BUL_MAX],
            meter_jiggle: 0.0,
            hud: hud::HudState::new(),
            title_idx: 0.0,
            title_speed: 0.0,
            title_y: 432.0,
            title_first: false,
            title_bong: false,
            title_alarm0: -1,
            title_alarm1: -1,
            title_alarm2: -1,
            sky_x: 146,
            sky_y: 407,
            fx_seq: 0,
            no_control: false,
            raw_prev: Input {
                space: false,
                left: false,
                right: false,
            },
        }
    }
    // boot: scrInitialize -> randomize(). GM's randomize seeds from elapsed
    // MONOTONIC microseconds: seed = rotl32(us, 16) ^ (us_lo + us_hi)
    // (verified against the runner at elapsed 0 -> 0 and 7s -> 0xcfaacfaa).
    // The platform layer reads the (libTAS-virtualized) clock and passes it in.
    pub fn boot(&mut self, elapsed_us: u64) {
        let lo = elapsed_us as u32;
        let hi = (elapsed_us >> 32) as u32;
        let seed = lo.rotate_left(16) ^ lo.wrapping_add(hi);
        self.rng.seed(seed);
    }
}

// obj_init_rm Alarm_0
fn alarm0_fire(gs: &mut GameState) {
    gs.show_splash += 1;
    gs.alarm0 = 180; // splashSpeed
    if gs.show_splash == 4 {
        gs.alarm0 = 240;
    }
    if gs.show_splash >= 5 {
        gs.alarm0 = 60;
    }
}

fn goto_menu(gs: &mut GameState) {
    gs.room = Room::Menu;
    gs.room_frame = 0;
    gs.alarm0 = -1;
    let mut r = rng::GmRng::zeroed();
    core::mem::swap(&mut r, &mut gs.rng);
    gs.pl.create(&mut r); // objPlayer_n: nap pose irandom(5)
    gs.cam.create(112, 512); // scrSpawnCamera (during player create)
    gs.cam.room_end = 448.0; // roomEndSetter: 624 - 176
    gs.scene.create(&mut r); // grass/trees in room instance order
    core::mem::swap(&mut r, &mut gs.rng);
    gs.no_control = true; // rm_menu creation code
                          // rm_menu Create: instance_create(ditherFade): image_speed=0, alarm[0]=30
    gs.fade_alive = true;
    gs.fade_alarm = 30;
    gs.fade_index = 0.0;
    gs.fade_speed = 0.0;
}

pub fn tick(gs: &mut GameState, input: Input) {
    // begin step (controller): scrControlInput. The menu consumes inputs
    // delayed by one frame (see raw_prev comment); the splash uses live input.
    if gs.room == Room::Menu {
        let d = gs.raw_prev;
        gs.inputs.update(d.space, d.left, d.right);
    } else {
        gs.inputs.update(input.space, input.left, input.right);
    }
    gs.raw_prev = input;
    gs.d_up = gs.inputs.d_up;

    match gs.room {
        Room::Init => {
            // alarm phase
            if gs.alarm0 > -1 {
                gs.alarm0 -= 1;
                if gs.alarm0 == 0 {
                    alarm0_fire(gs);
                }
            }
            // end step: obj_init_rm Step_2
            if !gs.room_dest_set {
                gs.room_dest_set = true;
                if gs.show_splash != 0 {
                    gs.alarm0 = 10;
                } else {
                    goto_menu(gs);
                }
            }
            if gs.show_splash != 0 {
                if gs.d_up {
                    gs.show_splash += 1;
                    gs.alarm0 = 60;
                }
                if gs.show_splash >= 7 {
                    gs.show_splash = 0;
                    goto_menu(gs);
                }
            }
        }
        Room::Menu => {
            // GM advances image_index after the draw: apply last frame's
            // advance at the start of this tick
            gs.scene.tick_anim();
            gs.pl.anim_advance();
            fx_anim_advance(&mut gs.fx);
            gs.title_idx += gs.title_speed;
            if gs.room_frame > 0 {
                if gs.fade_alive {
                    gs.fade_index += gs.fade_speed;
                    if gs.fade_index >= 12.0 {
                        gs.fade_alive = false; // Other_7: destroy -> control on
                        gs.no_control = false;
                    }
                }
            }
            // begin step: player Step_1
            {
                let GameState {
                    rng,
                    fx,
                    bullets,
                    pl,
                    cam,
                    meter_jiggle,
                    inputs,
                    no_control,
                    fx_seq,
                    ..
                } = gs;
                let mut ctx = player::StepCtx {
                    rng,
                    fx,
                    bullets,
                    inp: inputs,
                    no_control: *no_control,
                    meter_jiggle,
                    cam,
                    fx_seq,
                };
                pl.step_begin(&mut ctx);
            }
            // alarms: player, camera, ditherFade (creation order)
            gs.pl.alarms();
            gs.cam.alarms();
            title_alarms(gs);
            if gs.fade_alive && gs.fade_alarm > -1 {
                gs.fade_alarm -= 1;
                if gs.fade_alarm == 0 {
                    gs.fade_speed = 0.2;
                }
            }
            // normal steps: player Step_0, camMain, bullets, casings
            {
                let GameState {
                    rng,
                    fx,
                    bullets,
                    pl,
                    cam,
                    meter_jiggle,
                    inputs,
                    no_control,
                    fx_seq,
                    ..
                } = gs;
                let mut ctx = player::StepCtx {
                    rng,
                    fx,
                    bullets,
                    inp: inputs,
                    no_control: *no_control,
                    meter_jiggle,
                    cam,
                    fx_seq,
                };
                pl.step_normal(&mut ctx);
            }
            title_step(gs); // reads last frame's view (GM __view_get timing)
            {
                // objBgNightsky Step_0, same stale-view timing:
                // x = floor(120 + viewx/1.2); y = floor((viewy+142)/1.1)
                let vx = (gs.cam.x - 80).clamp(0, 416 - 160) as f64;
                let vy = (gs.cam.y - 142).clamp(0, 1200 - 284) as f64;
                gs.sky_x = floor_f64_i(120.0 + vx / 1.2);
                gs.sky_y = floor_f64_i((vy + 142.0) / 1.1);
            }
            {
                let GameState { rng, pl, cam, .. } = gs;
                cam.step(pl, rng);
            }
            let view_y = gs.cam.y - 142;
            for b in gs.bullets.iter_mut() {
                player::bullet_step(b, &mut gs.rng, &mut gs.fx, &mut gs.fx_seq, view_y);
            }
            fx_steps(&mut gs.fx);
            gs.room_frame += 1;
        }
    }

    gs.frame += 1;
}

// ---- draw ----------------------------------------------------------------
// obj_controler_n Draw_64 (GUI event), draw order preserved. Mutates state
// exactly where GM's draw event does (splashDithFrame).
pub fn draw(gs: &mut GameState, dl: &mut DrawList) {
    dl.clear();

    // shader block: borders + scrDrawHud4x3 (disp4x3, PC), then app surface —
    // all through shader 0 (shaderTemplate, DOWNWELL palette): mark pal=1.
    // sprTabletBorder origin (3,0); mirrored draw at x=162 with xscale -1.
    let block_start = dl.n;
    sprite_ext(dl, spr::TABLET_BORDER, 0, -2, 0);
    sprite_flipx(dl, spr::TABLET_BORDER, 0, 162, 0);
    {
        let GameState {
            hud,
            meter_jiggle,
            pl,
            ..
        } = gs;
        hud::draw_hud_4x3(dl, hud, meter_jiggle, pl.stammo, pl.p_fired);
    }
    let hud_end = dl.n;
    let mut bi = block_start;
    while bi < hud_end {
        dl.cmds[bi].pal = 1;
        bi += 1;
    }

    // application surface drawn over GUI 0..160 (covers in-surface HUD bits);
    // its draws carry pal=2 (palette + clip) themselves
    app_surface(gs, dl);

    // splash overlay
    if gs.show_splash != 0 {
        if gs.show_splash < 6 {
            rect(dl, -300, 0, 460, 400, C_BLACK);
        }
        match gs.show_splash {
            2 => sprite_ext(dl, spr::DEVOLVER, 0, 80, 140),
            3 => {
                border_text(dl, 80, 130, b"a game by#OJIRO FUMOTO", C_WHITE);
                border_text(dl, 80, 150, b"@MOPPIN_", C_RED);
                border_text(dl, 168, 200, b"EIRIK SUHRKE", C_WHITE);
                border_text(dl, 168, 210, b"@STROTCHY", C_RED);
                border_text(dl, -8, 200, b"JOONAS TURNER", C_WHITE);
                border_text(dl, -8, 210, b"@KISSAKOLME", C_RED);
                gs.splash_dith_frame = 11.0;
            }
            4 => {
                sprite_ext(dl, spr::CONTROLS, 0, 80, 140);
                gs.splash_dith_frame = 11.0;
            }
            5 => {
                sprite_ext(dl, spr::CONTROLS, 0, 80, 140);
                dither_tiled(dl, gs.splash_dith_frame as u16, -300, 0);
                if gs.splash_dith_frame >= 1.0 {
                    gs.splash_dith_frame -= 0.3;
                }
            }
            6 => {
                dither_tiled(dl, gs.splash_dith_frame as u16, -300, 0);
                if gs.splash_dith_frame <= 11.0 {
                    gs.splash_dith_frame += 0.3;
                }
            }
            _ => {}
        }
    }
}

// app-surface content (GUI 0..160 x 0..284). Slice 1: rm_init is black; rmMenu
// is fully covered by the surfaceDissipate dissolve while fade_index < ~1.
// TODO slice 2: room render + dissolve pattern + scrDrawHud4x3Top.
fn app_surface(gs: &mut GameState, dl: &mut DrawList) {
    let start = dl.n;
    rect(dl, 0, 0, 159, 283, C_BLACK);
    dl.cmds[start].pal = 2;
    if gs.room == Room::Menu {
        // view: centers on camMain (border 80/150 over-constrained -> center),
        // clamped to room bounds (416x1200)
        let mut vx = gs.cam.x - 80;
        let mut vy = gs.cam.y - 142;
        vx = vx.clamp(0, 416 - 160);
        vy = vy.clamp(0, 1200 - 284);
        gs.scene.draw_back(dl, vx, vy, (gs.sky_x, gs.sky_y));
        // depth 0: title, then jump fx / casings / bullets (behind player)
        if gs.title_first || gs.room_frame > 0 {
            dl.push(DrawCmd {
                sprite: 654,
                frame: gs.title_idx as u16,
                x: (328 - 64 - vx) as f32,
                y: (player::gm_round(gs.title_y) - 16 - vy) as f32,
                w: 128.0,
                h: 32.0,
                color: C_WHITE,
                pal: 2,
                rot: 0.0,
            });
        }
        draw_fx_group(&gs.fx, &gs.bullets, dl, vx, vy, 0);
        gs.pl.draw(dl, vx, vy); // depth -50000
                                // scrEffectSpawn fx: recharge -50500, muzzle -60000 (in front)
        draw_fx_group(&gs.fx, &gs.bullets, dl, vx, vy, 1);
        gs.scene.draw_grass(dl, vx, vy); // depth -100000
        menu::draw_dissolve(dl, gs.fade_index, gs.fade_alive);
    }
}

fn floor_f64_i(v: f64) -> i32 {
    let t = v as i32;
    if (t as f64) > v {
        t - 1
    } else {
        t
    }
}

// objTitle Step_0 (menu): trigger when centered in view, sparkle RNG chain
fn title_step(gs: &mut GameState) {
    if gs.pl.napping || !gs.pl.exists {
        // GM gates the whole trigger block on !objPlayer_n.napping
        if gs.pl.napping {
            return title_anim_tail(gs);
        }
    }
    let viewx = gs.cam.x - 80; // last frame's view (camera not yet stepped)
    if 328 > viewx + 80 - 4 && 328 < viewx + 80 + 4 && !gs.title_first {
        gs.title_alarm2 = 15;
        gs.title_first = true; // global.firstBoot = 1 (+ sound, no RNG)
    }
    title_anim_tail(gs);
}

fn title_anim_tail(gs: &mut GameState) {
    if gs.title_first {
        if gs.title_idx < 9.0 {
            if gs.rng.choose_index(2) == 1 {
                // emitMovingFx(x+rr(-66,66), y+rr(-16,16), choose(655,656),
                //              rr(0.1,0.5), 90, 0.1)
                // GML pushes call args RIGHT-TO-LEFT: evaluate in reverse
                let sp = gs.rng.random_range(0.1, 0.5) as f32;
                let which = gs.rng.choose_index(2);
                let fy = gs.title_y + gs.rng.random_range(-16.0, 16.0);
                let fx = 328.0 + gs.rng.random_range(-66.0, 66.0);
                // spawned mid-Step-dispatch: no Step of its own this frame
                spawn_sparkle(&mut gs.fx, &mut gs.fx_seq, fx, fy, which, sp, 0.1, true);
            }
        }
        if gs.title_idx > 9.0 {
            gs.title_speed = 0.0;
            if !gs.title_bong {
                gs.title_alarm0 = 1;
                gs.title_bong = true;
            }
        }
        gs.title_y = 432.0 - 3.0 * (gs.title_idx as f64 / 9.0);
    }
}

fn title_alarms(gs: &mut GameState) {
    if gs.title_alarm2 > -1 {
        gs.title_alarm2 -= 1;
        if gs.title_alarm2 == 0 {
            gs.title_speed = 0.32;
        }
    }
    if gs.title_alarm0 > -1 {
        gs.title_alarm0 -= 1;
        if gs.title_alarm0 == 0 {
            // repeat(20) emitMovingFx(x+rr(-70,70), y+rr(-16,16),
            //   choose(655,656), rr(0.035,0.2), 90, rr(0.1,0.2))
            for _ in 0..20 {
                // args right-to-left
                let vel = gs.rng.random_range(0.1, 0.2);
                let sp = gs.rng.random_range(0.035, 0.2) as f32;
                let which = gs.rng.choose_index(2);
                let fy = gs.title_y + gs.rng.random_range(-16.0, 16.0);
                let fx = 328.0 + gs.rng.random_range(-70.0, 70.0);
                // spawned in the ALARM phase: its Step_0 runs later this frame
                spawn_sparkle(&mut gs.fx, &mut gs.fx_seq, fx, fy, which, sp, vel, false);
            }
            gs.title_alarm1 = 75;
        }
    }
    if gs.title_alarm1 > -1 {
        gs.title_alarm1 -= 1;
        if gs.title_alarm1 == 0 {
            // objTeleportMain.titleOk = 1 (gameplay gate; no visual)
        }
    }
}

// parentMovingFx: dir 90 -> xsp 0, ysp -speed; anim-end kill
fn spawn_sparkle(
    fx: &mut [player::Fx; player::FX_MAX],
    seq: &mut u32,
    x: f64,
    y: f64,
    which: u32,
    img_sp: f32,
    vel: f64,
    fresh: bool,
) {
    *seq += 1;
    for slot in fx.iter_mut() {
        if !slot.alive {
            *slot = player::Fx {
                seq: *seq,
                alive: true,
                kind: if which == 1 { 7 } else { 6 }, // choose(655,656)
                x,
                y,
                ysp: -vel,
                image_speed: img_sp,
                angle: 90, // emitMovingFx: image_angle = arg4 = 90
                fresh,
                ..player::Fx::zeroed()
            };
            return;
        }
    }
}

// fx + bullet draws split by GM depth group:
// group 0 = depth 0 (jump fx kinds 0/1, casings, bullets) — behind the player
// group 1 = scrEffectSpawn depths (recharge -50500, muzzle -60000) — in front
fn draw_fx_group(
    fx: &[player::Fx; player::FX_MAX],
    bullets: &[player::Bullet; player::BUL_MAX],
    dl: &mut DrawList,
    vx: i32,
    vy: i32,
    group: u8,
) {
    // GM draws same-depth instances oldest-first: order by spawn seq, not
    // pool slot (slot reuse permutes overlap winners otherwise)
    let mut order: [u8; player::FX_MAX] = [0; player::FX_MAX];
    let mut n = 0usize;
    for (i, f) in fx.iter().enumerate() {
        if f.alive {
            order[n] = i as u8;
            n += 1;
        }
    }
    let mut k = 1;
    while k < n {
        let mut j = k;
        while j > 0 && fx[order[j - 1] as usize].seq > fx[order[j] as usize].seq {
            order.swap(j - 1, j);
            j -= 1;
        }
        k += 1;
    }
    for oi in 0..n {
        let f = &fx[order[oi] as usize];
        let fx_group = match f.kind {
            3 | 4 => 1,
            _ => 0,
        };
        if fx_group != group {
            continue;
        }
        let (spr_id, ox, oy, w, h): (u16, i32, i32, i32, i32) = match f.kind {
            0 => (94, 16, 16, 32, 32),  // sprJumpSmallerFx
            1 => (95, 16, 24, 32, 32),  // sprJumpFx
            2 => (457, 12, 12, 24, 24), // casing
            3 => (603, 16, 16, 32, 32), // muzzle (rotation TODO)
            4 => (111, 24, 42, 48, 72), // recharge burst at 0.75 scale
            5 => (101, 18, 30, 36, 36), // sprFxBulletHitWall
            6 => (655, 16, 16, 32, 32), // sprTitleSparkle1
            7 => (656, 16, 16, 32, 32), // sprTitleSparkle2
            _ => continue,
        };
        if f.kind == 2 && f.d_flash != 1 {
            continue; // casing Draw_0: if (dFlash) draw_self — GM truthy(1)
        }
        let sx = player::gm_round(f.x) - vx;
        let sy = player::gm_round(f.y) - vy;
        if f.kind == 0 {
            // draws both mirrors unless emitTo picks one
            if f.emit_to != 1 {
                dl.push(DrawCmd {
                    sprite: spr_id,
                    frame: f.image_index as u16,
                    x: (sx - ox) as f32,
                    y: (sy - oy) as f32,
                    w: w as f32,
                    h: h as f32,
                    color: C_WHITE,
                    pal: 2,
                    rot: 0.0,
                });
            }
            if f.emit_to != -1 {
                dl.push(DrawCmd {
                    sprite: spr_id,
                    frame: f.image_index as u16,
                    x: (sx + ox) as f32,
                    y: (sy - oy) as f32,
                    w: -(w as f32),
                    h: h as f32,
                    color: C_WHITE,
                    pal: 2,
                    rot: 0.0,
                });
            }
        } else {
            dl.push(DrawCmd {
                sprite: spr_id,
                frame: f.image_index as u16,
                x: (sx - ox) as f32,
                y: (sy - oy) as f32,
                w: w as f32,
                h: h as f32,
                color: C_WHITE,
                pal: 2,
                rot: if f.kind == 3 { f.angle as f32 } else { 0.0 },
            });
        }
    }
    if group == 0 {
        for b in bullets.iter() {
            if b.alive {
                dl.push(DrawCmd {
                    sprite: 459,
                    frame: b.image_index as u16,
                    x: (player::gm_round(b.x) - vx - 8) as f32,
                    y: (player::gm_round(b.y) - vy - 8) as f32,
                    w: 16.0,
                    h: 16.0,
                    color: C_WHITE,
                    pal: 2,
                    rot: b.b_dir as f32,
                });
            }
        }
    }
}

// engine anim advance + anim-end kills for fx
fn fx_anim_advance(fx: &mut [player::Fx; player::FX_MAX]) {
    for f in fx.iter_mut() {
        if !f.alive {
            continue;
        }
        f.image_index += f.image_speed;
        let frames = match f.kind {
            0 | 1 => 4,
            2 => 8,
            3 => 1,
            4 => 8,
            5 => 8,
            6 => 5,
            7 => 4,
            _ => 1,
        } as f32;
        if f.image_index >= frames {
            match f.kind {
                0 | 1 | 3 | 4 | 5 | 6 | 7 => f.alive = false, // anim-end kill
                2 => f.image_index -= frames,                 // casing loops
                _ => {}
            }
        } else if f.image_index < 0.0 {
            // casing negative image_speed wraps too
            f.image_index += frames;
        }
    }
}

// per-step fx behavior (casing physics; alarm)
fn fx_steps(fx: &mut [player::Fx; player::FX_MAX]) {
    for f in fx.iter_mut() {
        if !f.alive {
            continue;
        }
        if f.kind == 6 || f.kind == 7 {
            // parentMovingFx: no drift on the spawn frame (instances created
            // mid-Step-dispatch don't run that event this frame)
            if f.fresh {
                f.fresh = false;
            } else {
                f.x += f.xsp;
                f.y += f.ysp;
            }
        }
        if f.kind == 2 {
            // bullet_casing Step_0
            if f.ysp < -1.0 {
                f.ysp += 0.2; // ugravhard
            } else {
                f.ysp += 0.08; // ugrav
            }
            let next = (f.x + f.xsp) as i32;
            let pt = (next, next, f.y as i32, f.y as i32);
            if room_menu_gen::MENU_WALL_RECTS
                .iter()
                .any(|r| pt.0 <= r.2 && pt.1 >= r.0 && pt.2 <= r.3 && pt.3 >= r.1)
            {
                f.xsp *= -1.0;
                f.xsp *= 0.7;
            }
            if f.xsp.abs() < 0.05 {
                f.xsp = if f.xsp < 0.0 { -0.05 } else { 0.05 };
            }
            f.x += f.xsp;
            f.y += f.ysp;
            // Alarm_0(15): flashing=1, alarm[1]=15; Alarm_1: destroy.
            // Step_0 head: if (flashing) dFlash *= -1
            if f.alarm0 > -1 {
                f.alarm0 -= 1;
                if f.alarm0 == 0 {
                    f.flashing = true;
                    f.alarm1 = 15;
                }
            }
            if f.alarm1 > -1 {
                f.alarm1 -= 1;
                if f.alarm1 == 0 {
                    f.alive = false; // action_kill_object
                }
            }
            if f.flashing {
                f.d_flash = -f.d_flash;
            }
        }
    }
}

// ---- emit helpers ---------------------------------------------------------

// draw_sprite with origin applied from sprite_meta (apply_origin=true for
// sprites whose GML call passes center coords)
pub(crate) fn sprite_ext(dl: &mut DrawList, s: u16, frame: u16, x: i32, y: i32) {
    let (ox, oy, _) = sprite_meta(s);
    let (w, h) = sprite_size(s);
    let (dx, dy) = (x - ox, y - oy);
    dl.push(DrawCmd {
        sprite: s,
        frame,
        x: dx as f32,
        y: dy as f32,
        w: w as f32,
        h: h as f32,
        color: C_WHITE,
        pal: 0,
        rot: 0.0,
    });
}

// draw_sprite_ext(..., xscale=-1): flips around the origin point
pub(crate) fn sprite_flipx(dl: &mut DrawList, s: u16, frame: u16, x: i32, y: i32) {
    let (ox, oy, _) = sprite_meta(s);
    let (w, h) = sprite_size(s);
    // left edge = x - (w - ox)
    dl.push(DrawCmd {
        sprite: s,
        frame,
        x: (x + ox) as f32, // right edge; negative w extends left
        y: (y - oy) as f32,
        w: -(w as f32),
        h: h as f32,
        color: C_WHITE,
        pal: 0,
        rot: 0.0,
    });
}

// draw_sprite_stretched (origin ignored by GM for stretched draws)
pub(crate) fn sprite_stretched(
    dl: &mut DrawList,
    s: u16,
    frame: u16,
    x: i32,
    y: i32,
    w: f64,
    h: f64,
) {
    if w == 0.0 || h == 0.0 {
        return;
    }
    dl.push(DrawCmd {
        sprite: s,
        frame,
        x: x as f32,
        y: y as f32,
        w: w as f32,
        h: h as f32,
        color: C_WHITE,
        pal: 0,
        rot: 0.0,
    });
}

// dimensions live in the app's atlas table; sim only needs the handful below
pub(crate) fn sprite_size(s: u16) -> (i32, i32) {
    match s {
        spr::DEVOLVER => (160, 64),
        spr::CONTROLS => (160, 208),
        spr::DITHER => (8, 8),
        spr::TABLET_BORDER => (6, 284),
        spr::PC_HUD_HP_GAUGE => (88, 20),
        spr::HP_GAUGE_BAR => (3, 8),
        spr::RED_PIXEL | spr::PIXEL | spr::DOT => (1, 1),
        spr::SPRITE_NUMBER | spr::SPRITE_SLASH => (8, 8),
        spr::HUD_CURRENCY => (62, 18),
        spr::NEW_HUD_GAUGE => (160, 27),
        spr::STAMMO_GAUGE => (19, 196),
        spr::STAMMO_POP | spr::STAMMO_CHARGE | spr::STAMMO_DIVIDE => (12, 8),
        spr::PLAYER_NAP => (32, 32),
        spr::PLAYER_IDLE => (24, 24),
        _ => (0, 0),
    }
}

// GM draw_rectangle(x1,y1,x2,y2,false): inclusive of x2,y2
pub(crate) fn rect(dl: &mut DrawList, x1: i32, y1: i32, x2: i32, y2: i32, color: u32) {
    dl.push(DrawCmd {
        sprite: spr::RECT,
        frame: 0,
        x: x1 as f32,
        y: y1 as f32,
        w: (x2 - x1 + 1) as f32,
        h: (y2 - y1 + 1) as f32,
        color,
        pal: 0,
        rot: 0.0,
    });
}

// draw_sprite_tiled: 8x8 tiles phase-aligned to (ox,oy), covering the window
fn dither_tiled(dl: &mut DrawList, frame: u16, ox: i32, oy: i32) {
    let x0 = ox + ((GUI_XMIN - ox).div_euclid(8)) * 8;
    let y0 = oy + ((0 - oy).div_euclid(8)) * 8;
    let mut y = y0;
    while y < GUI_H {
        let mut x = x0;
        while x < GUI_XMAX {
            dl.push(DrawCmd {
                sprite: spr::DITHER,
                frame,
                x: x as f32,
                y: y as f32,
                w: 8.0,
                h: 8.0,
                color: C_WHITE,
                pal: 0,
                rot: 0.0,
            });
            x += 8;
        }
        y += 8;
    }
}

// ---- text (font0, halign center, valign top, '#' = newline) ----

fn glyph_index(b: u8) -> usize {
    if (b as u16) < FONT0_FIRST || b > 127 {
        0
    } else {
        (b as u16 - FONT0_FIRST) as usize
    }
}

fn draw_text_centered(dl: &mut DrawList, x: i32, y: i32, s: &[u8], color: u32) {
    let mut ly = y;
    for line in s.split(|&b| b == b'#') {
        let mut lw = 0i32;
        for &b in line {
            lw += FONT0_METRICS[glyph_index(b)].0 as i32;
        }
        let mut pen = x as f32 - lw as f32 / 2.0;
        for &b in line {
            let (shift, off, w) = FONT0_METRICS[glyph_index(b)];
            if w > 0 && b != b' ' {
                dl.push(DrawCmd {
                    sprite: spr::FONT0,
                    frame: b as u16,
                    x: pen + off as f32,
                    y: ly as f32,
                    w: w as f32,
                    h: 10.0,
                    color,
                    pal: 0,
                    rot: 0.0,
                });
            }
            pen += shift as f32;
        }
        ly += FONT0_LINE_H;
    }
}

// scrDrawBorderTextBlack / scrDrawBorderTextRed
fn border_text(dl: &mut DrawList, x: i32, y: i32, s: &[u8], color: u32) {
    draw_text_centered(dl, x + 1, y, s, C_BLACK);
    draw_text_centered(dl, x - 1, y, s, C_BLACK);
    draw_text_centered(dl, x, y + 1, s, C_BLACK);
    draw_text_centered(dl, x, y - 1, s, C_BLACK);
    draw_text_centered(dl, x, y, s, color);
}
