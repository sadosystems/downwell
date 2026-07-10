//! Browser frontend: pure simulation/composition plus a WebGPU/WebGL wgpu
//! presenter. Native builds retain the software rasterizer as a smoke-test
//! oracle; it is not shipped in the wasm binary.

mod compose;
#[cfg(not(target_arch = "wasm32"))]
mod raster;

use compose::{CIN_H, CIN_W};

// The simulation recreates Player when it transitions from rmInit to rmMenu,
// so frontend-specific player fields set at boot do not survive that first
// tick. Keep the custom web room's collision columns tied to its frame.
const WEB_MENU_BOUNDS: [i32; 2] = [(416 - CIN_W) / 2, (416 - CIN_W) / 2 + CIN_W];

fn configure_web_player(gs: &mut sim::GameState) {
    gs.pl.menu_bounds = WEB_MENU_BOUNDS;
    if gs.pl.napping {
        // rmMenu chooses one of several idle poses at random. The web room
        // always opens on the animated, upright bench pose (sprLegSwing).
        gs.pl.nap_sprite = 12;
        gs.pl.nap_img_sp = 0.15;
        gs.pl.nap_x = 112.0;
        gs.pl.nap_y = 512.0;
        gs.pl.nap_xscale = 1.0;
    }
}

const DW_PAL: [[f32; 3]; 4] = [
    [250.0 / 256.0, 250.0 / 256.0, 250.0 / 256.0],
    [250.0 / 256.0, 0.0, 0.0],
    [5.0 / 256.0, 5.0 / 256.0, 5.0 / 256.0],
    [0.0, 126.0 / 256.0, 250.0 / 256.0],
];

fn unpack(v: u32) -> [f32; 3] {
    [
        ((v >> 16) & 0xff) as f32 / 255.0,
        ((v >> 8) & 0xff) as f32 / 255.0,
        (v & 0xff) as f32 / 255.0,
    ]
}

fn tick(gs: &mut sim::GameState, dl: &mut sim::DrawList, input: u32) {
    configure_web_player(gs);
    sim::tick(
        gs,
        sim::Input {
            space: input & 1 != 0,
            left: input & 2 != 0,
            right: input & 4 != 0,
        },
    );
    // goto_menu() calls Player::create(), which resets menu_bounds. Restore it
    // immediately so the first controllable menu tick uses the widened room.
    configure_web_player(gs);
    sim::draw(gs, dl);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn web_bounds_survive_the_init_to_menu_transition() {
        let mut gs = sim::GameState::new();
        let mut dl = sim::DrawList::EMPTY;
        gs.boot(0);
        gs.show_splash = 0;
        gs.pl.menu_bounds = WEB_MENU_BOUNDS;

        tick(&mut gs, &mut dl, 0);

        assert!(gs.room == sim::Room::Menu);
        assert_eq!(gs.pl.menu_bounds, WEB_MENU_BOUNDS);
        assert_eq!(gs.pl.nap_sprite, 12);
        assert_eq!(gs.pl.nap_img_sp, 0.15);
        assert_eq!((gs.pl.nap_x, gs.pl.nap_y), (112.0, 512.0));
    }
}

#[cfg(target_arch = "wasm32")]
mod browser {
    use super::*;
    use wasm_bindgen::prelude::*;

    #[wasm_bindgen]
    pub struct WebGame {
        gs: sim::GameState,
        dl: sim::DrawList,
        composed: Vec<sim::DrawCmd>,
        renderer: render::Renderer,
    }

    #[wasm_bindgen]
    impl WebGame {
        pub fn frame(&mut self, input: u32) -> Result<(), JsValue> {
            tick(&mut self.gs, &mut self.dl, input);
            compose::cinema(&self.gs, &self.dl, &mut self.composed);
            self.renderer
                .render(&self.composed, 1.0, 0.0)
                .map_err(|e| JsValue::from_str(&e))
        }

        pub fn set_palette(&mut self, l: u32, m: u32, d: u32, s: u32) {
            self.renderer
                .set_palette([unpack(l), unpack(m), unpack(d), unpack(s)]);
        }
    }

    /// WebGPU adapter/device acquisition is asynchronous in browsers, so the
    /// JS entry point awaits this factory before starting its animation loop.
    #[wasm_bindgen]
    pub async fn create_game(
        canvas: web_sys::HtmlCanvasElement,
        atlas: web_sys::ImageBitmap,
    ) -> Result<WebGame, JsValue> {
        let mut gs = sim::GameState::new();
        gs.boot(0);
        gs.show_splash = 0;
        // The cinema composition extends the rmMenu world to the full frame.
        // Replace its original side-wall columns with columns just outside
        // the visible world: frame-space 0 and CIN_W map to these room x's.
        gs.pl.menu_bounds = WEB_MENU_BOUNDS;
        let mut renderer = render::Renderer::for_canvas(
            canvas,
            atlas,
            CIN_W as u32,
            CIN_H as u32,
            (0.0, CIN_W as f32),
        )
        .await
        .map_err(|e| JsValue::from_str(&e))?;
        renderer.set_palette(DW_PAL);
        Ok(WebGame {
            gs,
            dl: sim::DrawList::EMPTY,
            composed: Vec::with_capacity(4096),
            renderer,
        })
    }
}

// Native-only compatibility API used by tests and frame dumps.
#[cfg(not(target_arch = "wasm32"))]
mod native {
    use super::*;
    use std::sync::{Mutex, OnceLock};

    const FB_LEN: usize = CIN_W as usize * CIN_H as usize * 4;
    struct State {
        gs: sim::GameState,
        dl: sim::DrawList,
        composed: Vec<sim::DrawCmd>,
        pal: [[f32; 3]; 4],
        fb: Vec<u8>,
        baked: Box<[u8]>,
        dirty: bool,
    }
    fn state() -> &'static Mutex<State> {
        static STATE: OnceLock<Mutex<State>> = OnceLock::new();
        STATE.get_or_init(|| {
            Mutex::new(State {
                gs: sim::GameState::new(),
                dl: sim::DrawList::EMPTY,
                composed: Vec::with_capacity(4096),
                pal: DW_PAL,
                fb: vec![0; FB_LEN],
                baked: vec![0; raster::ATLAS_PX * 4].into_boxed_slice(),
                dirty: true,
            })
        })
    }
    pub fn boot(_: u32) {
        let mut s = state().lock().unwrap();
        s.gs = sim::GameState::new();
        s.gs.boot(0);
        s.gs.show_splash = 0;
        s.gs.pl.menu_bounds = WEB_MENU_BOUNDS;
        s.pal = DW_PAL;
        s.dirty = true;
    }
    pub fn set_palette(l: u32, m: u32, d: u32, sp: u32) {
        let mut s = state().lock().unwrap();
        s.pal = [unpack(l), unpack(m), unpack(d), unpack(sp)];
        s.dirty = true;
    }
    pub fn frame(input: u32) {
        let mut s = state().lock().unwrap();
        let State { gs, dl, .. } = &mut *s;
        tick(gs, dl, input);
        let State {
            gs, dl, composed, ..
        } = &mut *s;
        compose::cinema(gs, dl, composed);
        if s.dirty {
            let pal = s.pal;
            raster::bake(&pal, &mut s.baked);
            s.dirty = false;
        }
        let d = s.pal[2];
        raster::clear(
            &mut s.fb,
            CIN_W as usize * CIN_H as usize,
            [
                raster::to_u8(d[0]),
                raster::to_u8(d[1]),
                raster::to_u8(d[2]),
            ],
        );
        let view = raster::View {
            w: CIN_W as usize,
            h: CIN_H as usize,
            off_x: 0.0,
            scale: 1.0,
            clip: (0.0, CIN_W as f32),
        };
        let State {
            composed,
            pal,
            baked,
            fb,
            ..
        } = &mut *s;
        raster::raster(composed, fb, &view, pal, &baked[..]);
    }
    pub fn fb_ptr() -> *const u8 {
        state().lock().unwrap().fb.as_ptr()
    }
    pub fn fb_w() -> u32 {
        CIN_W as u32
    }
    pub fn fb_h() -> u32 {
        CIN_H as u32
    }
}

#[cfg(not(target_arch = "wasm32"))]
pub use native::*;
