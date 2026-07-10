// Cinema composition: the sim's GUI DrawList -> the custom web overworld,
// as a flat command list in frame space (GUI units, origin = frame corner).
// Pure data -> data, shared by both backends: the wgpu renderer in the
// browser and the software rasterizer in native tests.
//
// The custom room is the sim's rmMenu with:
//  - chrome dropped (pal != 2: HUD, tablet borders, splash),
//  - a LOCKED stage frame covering the whole playable area (the player can
//    never leave the screen); only screen shake moves it, recovered from the
//    sim camera's integer-vs-smooth difference,
//  - the ground plane continued sideways/downward past the room's tiles,
//  - the sky and the larger left-side vegetation removed, leaving the grass,
//    bench, and little tree,
//  - no DOWNWELL wordmark (the sim still runs the title state machine — its
//    RNG consumption is part of the frame-accuracy contract),
//  - the rmMenu dissolve retiled over the whole frame.
use sim::{DrawCmd, DrawList, GameState};

pub const CIN_W: i32 = 560;
pub const CIN_H: i32 = 382;

pub fn cinema(gs: &GameState, src: &DrawList, out: &mut Vec<DrawCmd>) {
    out.clear();
    // sim's view origin (sim/src/lib.rs app_surface), recomputed identically
    let vx = (gs.cam.x - 80).clamp(0, 416 - 160);
    let vy = (gs.cam.y - 142).clamp(0, 1200 - 284);
    // locked frame: room centered, vertical anchor on the settled camera
    // height; shake = cam.x/y (integer, shake baked in) - rounded xx/yy
    let shake_x = gs.cam.x - sim::player::gm_round(gs.cam.xx);
    let shake_y = gs.cam.y - sim::player::gm_round(gs.cam.yy);
    let vxc = (416 - CIN_W) / 2 + shake_x;
    let vyc = 448 - CIN_H / 2 + shake_y;
    let (dx, dy) = ((vx - vxc) as f32, (vy - vyc) as f32);

    // flat surface tile frame, sampled mid-room (row y=528) so a regenerated
    // room keeps working
    let mut surf_frame = 0u16;
    let mut best = i32::MAX;
    for c in &src.cmds[..src.n] {
        if c.pal == 2 && c.sprite == 76 && c.y as i32 + vy == 520 {
            let d = (c.x as i32 + vx + 8 - 208).abs();
            if d < best {
                best = d;
                surf_frame = c.frame;
            }
        }
    }

    let mut ground_emitted = false;
    let mut dissolve: Option<u16> = None;
    for c in &src.cmds[..src.n] {
        if c.pal != 2 {
            continue; // HUD, tablet borders, splash overlay
        }
        if c.sprite == sim::spr::DITHER {
            dissolve = Some(c.frame);
            continue;
        }
        // extended ground goes just before the room's own tiles, so the real
        // tiles (and the well/shaft, drawn later) paint over it
        if !ground_emitted && (c.sprite == 76 || c.sprite == 997) {
            ground_emitted = true;
            ground_extension(out, vxc, vyc, surf_frame);
        }
        // Web-room decoration pass. bgNightsky contains both the stars and
        // moon. Sprite 631 is the big tree. Of the two sprTrees instances,
        // the centered one at world x=160 (top-left 152 after its origin) is
        // the bush; retain the left instance as the little tree.
        if c.sprite == 369 {
            continue;
        }
        if c.sprite == 631 || (c.sprite == 646 && c.x as i32 + vx == 152) {
            continue;
        }
        // title fade (654) + sparkles (655/656): not drawn in the web world
        if matches!(c.sprite, 654..=656) {
            continue;
        }
        // the sim's 160x284 surface clear rect: replaced by the frame clear
        if c.sprite == sim::spr::RECT
            && c.color == sim::C_BLACK
            && c.x == 0.0
            && c.y == 0.0
            && c.w == 160.0
            && c.h == 284.0
        {
            continue;
        }
        let mut c2 = *c;
        // rmMenu's original surface ends use left/right edge-cap autotiles
        // (centers -32 and 448). They become interior tiles in the widened
        // web room, so use the same flat frame as the extension at each join.
        let world_x = c.x as i32 + vx;
        let world_y = c.y as i32 + vy;
        if c.sprite == 76 && world_y == 520 && matches!(world_x, -40 | 440) {
            c2.frame = surf_frame;
        }
        c2.x += dx;
        c2.y += dy;
        out.push(c2);
    }
    // dissolve: view-anchored, retiled over the whole frame
    if let Some(frame) = dissolve {
        let mut y = 0;
        while y < CIN_H {
            let mut x = 0;
            while x < CIN_W {
                out.push(tile_cmd(sim::spr::DITHER, frame, x as f32, y as f32, 8.0));
                x += 8;
            }
            y += 8;
        }
    }
}

fn tile_cmd(sprite: u16, frame: u16, x: f32, y: f32, size: f32) -> DrawCmd {
    DrawCmd {
        sprite,
        frame,
        x,
        y,
        w: size,
        h: size,
        color: sim::C_WHITE,
        pal: 2,
        rot: 0.0,
    }
}

// The custom overworld's extra ground: the flat surface row continued
// sideways past the room's -32..448 tile span, and dirt (997) tiled across
// the whole below-ground region. World-space grids match the room's own
// (surface x = -32+16k, dirt from y=536), so extensions land pixel-exact on
// the originals they meet; frame coords = world - (vxc, vyc).
fn ground_extension(out: &mut Vec<DrawCmd>, vxc: i32, vyc: i32, surf_frame: u16) {
    let mut wx = -32 - 16;
    while wx + 8 > vxc - 16 {
        out.push(tile_cmd(
            76,
            surf_frame,
            (wx - 8 - vxc) as f32,
            (520 - vyc) as f32,
            16.0,
        ));
        wx -= 16;
    }
    let mut wx = 448 + 16;
    while wx - 8 < vxc + CIN_W {
        out.push(tile_cmd(
            76,
            surf_frame,
            (wx - 8 - vxc) as f32,
            (520 - vyc) as f32,
            16.0,
        ));
        wx += 16;
    }
    let mut wy = 536;
    while wy < vyc + CIN_H {
        let mut wx = -24 - ((-24 - (vxc - 16)) / 16) * 16 - 16;
        while wx < vxc + CIN_W {
            out.push(tile_cmd(997, 0, (wx - vxc) as f32, (wy - vyc) as f32, 16.0));
            wx += 16;
        }
        wy += 16;
    }
}
