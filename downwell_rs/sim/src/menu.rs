// rmMenu idle scene: instance creation chain (RNG in exact ROOM instance
// order) + per-frame rendering of the visible slice through the settled
// camera view.
//
// Camera: settles at (112,448) -> view (32,306) before anything is visible
// (proven by pixel-exact template match; dynamic camera port comes with
// gameplay — see NOTES.md open question on the y target).
use crate::rng::GmRng;
use crate::room_menu_gen::{MENU_FILLERS, MENU_GRASS, MENU_WALLS};
use crate::{spr, DrawCmd, DrawList, C_WHITE};

fn floor_f64(v: f64) -> i32 {
    let t = v as i32;
    if (t as f64) > v {
        t - 1
    } else {
        t
    }
}

#[repr(C)]
#[derive(Clone, Copy)]
pub struct Tuft {
    pub x: i32,
    pub sprite: u16, // 635..638
    // GM stores image_speed/image_index as f32 engine fields (GML vars are
    // f64) — f32 accumulation reproduces the capture's frame boundaries
    pub speed: f32,
    pub idx: f32,
    pub alive: bool,
}

#[repr(C)]
pub struct MenuScene {
    pub tufts: [Tuft; 14],
    pub tree_frame: u16,        // objTree (spr 631)
    pub trees_frames: [u16; 2], // groundTrees @160, @-16 (spr 646)
}

impl MenuScene {
    pub const fn zeroed() -> MenuScene {
        MenuScene {
            tufts: [Tuft {
                x: 0,
                sprite: 0,
                speed: 0.0,
                idx: 0.0,
                alive: false,
            }; 14],
            tree_frame: 0,
            trees_frames: [0, 0],
        }
    }

    // Room-start instance creation, RNG consumption in ROOM instance order:
    // objPlayer_n (nap pose), grass 48/240/32, objTree, groundTrees@160,
    // remaining 11 grass, groundTrees@-16. (Verified by gdb call trace.)
    // grass/trees only — the player (pose irandom) is created before this
    pub fn create(&mut self, rng: &mut GmRng) {
        for (t, tuft) in self.tufts.iter_mut().enumerate() {
            let v = rng.choose_index(4) as u16; // choose(sprGrass..sprGrass4)
            let speed = rng.random_range(0.15, 0.25) as f32;
            let idx = rng.irandom(3) as f32; // irandom(image_number - 1)
            let alive = rng.random(10.0) >= 1.0;
            *tuft = Tuft {
                x: MENU_GRASS[t].0,
                sprite: 635 + v,
                speed,
                idx,
                alive,
            };
            if t == 2 {
                // objTree: choose(0,0,0,0,0,1)
                self.tree_frame = if rng.choose_index(6) == 5 { 1 } else { 0 };
                self.trees_frames[0] = rng.irandom(3) as u16;
            }
        }
        self.trees_frames[1] = rng.irandom(3) as u16;
    }

    // per-frame animation advance (GM: image_index += image_speed each frame)
    pub fn tick_anim(&mut self) {
        for t in self.tufts.iter_mut() {
            t.idx += t.speed;
            if t.idx >= 4.0 {
                t.idx -= 4.0;
            }
        }
    }

    // room draw in depth order (high first). GUI coords = room - view.
    // draw_back: everything at depth > player (-50000); grass (below) separate.
    pub fn draw_back(&self, dl: &mut DrawList, vx: i32, vy: i32, sky: (i32, i32)) {
        let at = |dl: &mut DrawList, s: u16, frame: u16, x: i32, y: i32, ox: i32, oy: i32| {
            dl.push(DrawCmd {
                sprite: s,
                frame,
                x: (x - ox - vx) as f32,
                y: (y - oy - vy) as f32,
                w: 0.0, // filled by size below
                h: 0.0,
                color: C_WHITE,
                pal: 2,
                rot: 0.0,
            });
            let n = dl.n - 1;
            let (w, h) = sprite_px(s);
            dl.cmds[n].w = w as f32;
            dl.cmds[n].h = h as f32;
        };

        // depth 100000: objTree (64,512) then groundTrees (160,400), (-16,400)
        at(dl, 631, self.tree_frame, 64, 512, 64, 119);
        at(dl, 646, self.trees_frames[0], 160, 400, 8, 8);
        at(dl, 646, self.trees_frames[1], -16, 400, 8, 8);
        // depth 10000: bgNightsky at its Step-computed position (1-frame
        // stale view, GM timing) — passed in by the caller
        at(dl, 369, 0, sky.0, sky.1, 119, 104);
        // depth 1000: bench
        at(dl, 640, 0, 112, 512, 16, 16);
        // depth 100: walls (autotiled) + interior filler tiles
        for &(x, y, frame, lights) in MENU_WALLS.iter() {
            at(dl, 76, frame, x, y, 8, 8);
            for l in lights {
                if l >= 0 {
                    at(dl, 76, l as u16, x, y, 8, 8);
                }
            }
        }
        for &(x, y) in MENU_FILLERS.iter() {
            at(dl, 997, 0, x, y, 0, 0);
        }
        // depth 90: objWell (272,512) — black shaft rect then sprWell2.
        // draw_rectangle(x-24, y+64, x+136, y+1512) inclusive
        dl.push(DrawCmd {
            sprite: 998, // solid fill
            frame: 0,
            x: (248 - vx) as f32,
            y: (576 - vy) as f32,
            w: 161.0,
            h: 1449.0,
            color: crate::C_BLACK,
            pal: 2,
            rot: 0.0,
        });
        at(dl, 642, 0, 272, 512, 8, 8);
    }

    // depth -100000: grass on top of the player
    pub fn draw_grass(&self, dl: &mut DrawList, vx: i32, vy: i32) {
        let at = |dl: &mut DrawList, s: u16, frame: u16, x: i32, y: i32, ox: i32, oy: i32| {
            dl.push(DrawCmd {
                sprite: s,
                frame,
                x: (x - ox - vx) as f32,
                y: (y - oy - vy) as f32,
                w: 24.0,
                h: 16.0,
                color: C_WHITE,
                pal: 2,
                rot: 0.0,
            });
        };
        for t in self.tufts.iter() {
            if t.alive {
                at(dl, t.sprite, t.idx as u16, t.x, 512, 12, 8);
            }
        }
    }
}

// sprite pixel sizes for the scene set (from gmdata)
fn sprite_px(s: u16) -> (i32, i32) {
    match s {
        631 => (128, 128), // sprTree
        646 => (80, 128),  // sprTrees
        369 => (240, 160), // bgNightsky
        640 => (32, 32),   // sprBench
        642 => (128, 128), // sprWell2
        76 => (16, 16),    // sprTileSurface
        997 => (16, 16),   // tileCavern filler
        11..=19 => (32, 32),
        635..=638 => (24, 16),
        _ => crate::sprite_size(s),
    }
}

pub fn draw_dissolve(dl: &mut DrawList, fade_index: f32, fade_alive: bool) {
    if !fade_alive {
        return;
    }
    // dither_fade tiles sprDitherFade[floor(image_index)] at (0,0) into the
    // 160x284 dissolve surface, drawn at view pos = exactly the app region.
    let frame = fade_index as u16;
    let mut y = 0;
    while y < 284 {
        let mut x = 0;
        while x < 160 {
            dl.push(DrawCmd {
                sprite: spr::DITHER,
                frame,
                x: x as f32,
                y: y as f32,
                w: 8.0,
                h: 8.0,
                color: C_WHITE,
                pal: 2,
                rot: 0.0,
            });
            x += 8;
        }
        y += 8;
    }
}
