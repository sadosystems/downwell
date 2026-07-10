// Software rasterizer: the native test backend (cargo test renders composed
// frames to PPM without a GPU). Mirrors render/src/shader.wgsl semantics —
// same palette classification, clip, blending, rotation.
//
// Hot paths work from a palette-baked atlas (bake once per palette change,
// then sample-and-copy); the general path survives for rotation and
// non-white tints.
use render::atlas_gen;
use render::ATLAS;

pub const ATLAS_PX: usize = (atlas_gen::ATLAS_W * atlas_gen::ATLAS_H) as usize;

pub struct View {
    pub w: usize, // fb px
    pub h: usize,
    pub off_x: f32,       // target-px x offset after scale
    pub scale: f32,       // GUI units -> fb px
    pub clip: (f32, f32), // pal=2 x clip, target px
}

pub fn clear(fb: &mut [u8], n: usize, c: [u8; 3]) {
    fb[..n * 4]
        .chunks_exact_mut(4)
        .for_each(|p| p.copy_from_slice(&[c[0], c[1], c[2], 255]));
}

pub fn raster(cmds: &[sim::DrawCmd], fb: &mut [u8], v: &View, pal: &[[f32; 3]; 4], baked: &[u8]) {
    for c in cmds {
        draw_cmd(c, fb, v, pal, baked);
    }
}

// run the palette over every atlas texel once; draw_cmd's hot path then just
// samples and copies (binary alpha)
pub fn bake(pal: &[[f32; 3]; 4], out: &mut [u8]) {
    assert_eq!(out.len(), ATLAS_PX * 4);
    for (i, t) in ATLAS.chunks_exact(4).enumerate() {
        let mut c = [
            t[0] as f32 / 255.0,
            t[1] as f32 / 255.0,
            t[2] as f32 / 255.0,
            t[3] as f32 / 255.0,
        ];
        palette(&mut c, pal);
        let o = &mut out[i * 4..][..4];
        o[0] = to_u8(c[0]);
        o[1] = to_u8(c[1]);
        o[2] = to_u8(c[2]);
        o[3] = if c[3] >= 0.5 { 255 } else { 0 };
    }
}

fn draw_cmd(c: &sim::DrawCmd, fb: &mut [u8], v: &View, pal: &[[f32; 3]; 4], baked: &[u8]) {
    let (rx, ry, rw, rh) = atlas_gen::sprite_rect(c.sprite, c.frame);
    if rw == 0 || rh == 0 {
        return;
    }
    // negative w/h flips: normalize the rect, swap uv
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
    // target-px rect
    let wx = gx * v.scale + v.off_x;
    let wy = gy * v.scale;
    let ww = gw * v.scale;
    let wh = gh * v.scale;

    let tint = [
        ((c.color >> 24) & 0xFF) as f32 / 255.0,
        ((c.color >> 16) & 0xFF) as f32 / 255.0,
        ((c.color >> 8) & 0xFF) as f32 / 255.0,
        (c.color & 0xFF) as f32 / 255.0,
    ];
    let th = c.rot.to_radians();

    // pixel bounds: AABB of the (possibly rotated) quad
    let (x0, x1, y0, y1) = if th == 0.0 {
        (wx, wx + ww, wy, wy + wh)
    } else {
        let ctr = (wx + 0.5 * ww, wy + 0.5 * wh);
        let (s, co) = th.sin_cos();
        let mut xs = (f32::MAX, f32::MIN);
        let mut ys = (f32::MAX, f32::MIN);
        for corner in [(wx, wy), (wx + ww, wy), (wx, wy + wh), (wx + ww, wy + wh)] {
            let d = (corner.0 - ctr.0, corner.1 - ctr.1);
            let px = ctr.0 + d.0 * co + d.1 * s;
            let py = ctr.1 - d.0 * s + d.1 * co;
            xs = (xs.0.min(px), xs.1.max(px));
            ys = (ys.0.min(py), ys.1.max(py));
        }
        (xs.0, xs.1, ys.0, ys.1)
    };
    let clip_x = if c.pal == 2 {
        v.clip
    } else {
        (0.0, v.w as f32)
    };
    let px0 = (x0.max(clip_x.0) - 0.5).ceil().max(0.0) as usize;
    let px1 = ((x1.min(clip_x.1) - 0.5).ceil()).clamp(0.0, v.w as f32) as usize;
    let py0 = (y0.max(0.0) - 0.5).ceil() as usize;
    let py1 = ((y1 - 0.5).ceil()).clamp(0.0, v.h as f32) as usize;
    if px0 >= px1 || py0 >= py1 {
        return;
    }

    // ---- fast paths (the whole cinema frame in practice) ----
    // solid rect: uniform colour, no sampling (RECT's texel is solid white,
    // so texel * tint == tint; same classification as the slow path)
    if c.sprite == sim::spr::RECT && th == 0.0 {
        let mut col = tint;
        if c.pal >= 1 {
            palette(&mut col, pal);
        }
        if col[3] >= 1.0 {
            let b = [to_u8(col[0]), to_u8(col[1]), to_u8(col[2]), 255];
            for py in py0..py1 {
                fb[(py * v.w + px0) * 4..(py * v.w + px1) * 4]
                    .chunks_exact_mut(4)
                    .for_each(|p| p.copy_from_slice(&b));
            }
        } else if col[3] > 0.0 {
            for py in py0..py1 {
                for px in px0..px1 {
                    blend(fb, py * v.w + px, col);
                }
            }
        }
        return;
    }
    // white-tinted palette sprite, axis-aligned: sample the palette-baked
    // atlas and copy — binary alpha, so "skip or overwrite" is exact
    if c.pal >= 1 && c.color == sim::C_WHITE && th == 0.0 {
        const AW: usize = atlas_gen::ATLAS_W as usize;
        const AH: usize = atlas_gen::ATLAS_H as usize;
        let du = (u1 - u0) / ww;
        let dv = (v1 - v0) / wh;
        let mut av_f = v0 + (py0 as f32 + 0.5 - wy) * dv;
        for py in py0..py1 {
            let arow = (av_f as usize).min(AH - 1) * AW;
            av_f += dv;
            let mut au_f = u0 + (px0 as f32 + 0.5 - wx) * du;
            let frow = py * v.w;
            for px in px0..px1 {
                let au = (au_f as usize).min(AW - 1);
                au_f += du;
                let s = &baked[(arow + au) * 4..][..4];
                if s[3] != 0 {
                    fb[(frow + px) * 4..][..4].copy_from_slice(s);
                }
            }
        }
        return;
    }

    // ---- general path: rotation, tinted sprites ----
    let (s, co) = th.sin_cos();
    let ctr = (wx + 0.5 * ww, wy + 0.5 * wh);
    for py in py0..py1 {
        for px in px0..px1 {
            let (mut fx, mut fy) = (px as f32 + 0.5, py as f32 + 0.5);
            if th != 0.0 {
                // inverse of the vertex rotation
                let d = (fx - ctr.0, fy - ctr.1);
                fx = ctr.0 + d.0 * co - d.1 * s;
                fy = ctr.1 + d.0 * s + d.1 * co;
            }
            let tx = (fx - wx) / ww;
            let ty = (fy - wy) / wh;
            if !(0.0..1.0).contains(&tx) || !(0.0..1.0).contains(&ty) {
                continue;
            }
            let au = ((u0 + tx * (u1 - u0)) as usize).min(atlas_gen::ATLAS_W as usize - 1);
            let av = ((v0 + ty * (v1 - v0)) as usize).min(atlas_gen::ATLAS_H as usize - 1);
            let t = &ATLAS[(av * atlas_gen::ATLAS_W as usize + au) * 4..][..4];
            let mut col = [
                t[0] as f32 / 255.0,
                t[1] as f32 / 255.0,
                t[2] as f32 / 255.0,
                t[3] as f32 / 255.0,
            ];
            for i in 0..4 {
                col[i] *= tint[i];
            }
            if c.pal >= 1 {
                palette(&mut col, pal);
            }
            if col[3] <= 0.0 {
                continue;
            }
            blend(fb, py * v.w + px, col);
        }
    }
}

fn step(edge: f32, v: f32) -> f32 {
    if v >= edge {
        1.0
    } else {
        0.0
    }
}

pub fn to_u8(v: f32) -> u8 {
    (v * 255.0 + 0.5) as u8
}

// GM shader 0 (shaderTemplate): threshold r/b/a, classify by channel, remap
// to the 4-color palette — same math as render/src/shader.wgsl fs_main.
fn palette(c: &mut [f32; 4], pal: &[[f32; 3]; 4]) {
    c[0] = step(0.5, c[0]);
    c[2] = step(0.5, c[2]);
    c[3] = step(0.5, c[3]);
    let [l, m, d, s] = pal;
    let white = step(0.8, c[1]);
    let blue = step(0.8, c[2]) - white;
    let red = step(0.5, c[0] - c[1]);
    let black = step(0.5, 1.0 - c[0] - c[1] - c[2]);
    for (sel, slot) in [(black, d), (red, m), (blue, s), (white, l)] {
        if step(0.5, sel) == 1.0 {
            c[0] = slot[0];
            c[1] = slot[1];
            c[2] = slot[2];
        }
    }
}

// straight-alpha over (ALPHA_BLENDING)
fn blend(fb: &mut [u8], idx: usize, src: [f32; 4]) {
    let d = &mut fb[idx * 4..][..4];
    let sa = src[3];
    for i in 0..3 {
        let dst = d[i] as f32 / 255.0;
        d[i] = ((src[i] * sa + dst * (1.0 - sa)) * 255.0 + 0.5) as u8;
    }
    let da = d[3] as f32 / 255.0;
    d[3] = ((sa + da * (1.0 - sa)) * 255.0 + 0.5) as u8;
}
