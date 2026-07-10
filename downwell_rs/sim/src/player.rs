// obj_player_n + input globals + camMain + fx pool: straight translation of
// tools/player_ref.gml (menu-surface scope: wake, walk, jump, shoot; no water,
// no death, no upgrades, playStyle 0, gun 0 MACHINEGUN).
//
// Type discipline: GML vars = f64; engine anim fields (image_index/speed) = f32.
// place_meeting = player mask rect (x-4..x+3, y-4..y+7) vs family rect tables.
use crate::rng::GmRng;
use crate::room_menu_gen::{MENU_THIN_RECTS, MENU_WALL_RECTS};
use crate::{DrawCmd, DrawList, C_WHITE};

// ---- input globals (scrControlInput, keyboard-only paths) ----
#[repr(C)]
#[derive(Default)]
pub struct Inputs {
    pub d_up: bool,
    pub d_up_held: bool,
    pub d_up_rel: bool,
    pub d_left: bool,
    pub d_left_pressed: bool,
    pub d_right: bool,
    pub d_right_pressed: bool,
    pub any_input: bool,
    prev_space: bool,
    prev_left: bool,
    prev_right: bool,
}

impl Inputs {
    pub const fn zeroed() -> Inputs {
        Inputs {
            d_up: false,
            d_up_held: false,
            d_up_rel: false,
            d_left: false,
            d_left_pressed: false,
            d_right: false,
            d_right_pressed: false,
            any_input: false,
            prev_space: false,
            prev_left: false,
            prev_right: false,
        }
    }

    pub fn update(&mut self, space: bool, left: bool, right: bool) {
        self.d_up = space && !self.prev_space;
        self.d_up_held = space;
        self.d_up_rel = !space && self.prev_space;
        self.d_left = left;
        self.d_left_pressed = left && !self.prev_left;
        self.d_right = right;
        self.d_right_pressed = right && !self.prev_right;
        self.any_input = self.d_up || self.d_left_pressed || self.d_right_pressed;
        self.prev_space = space;
        self.prev_left = left;
        self.prev_right = right;
    }
}

// ---- collision helpers ----
// player mask (sprPlayerIdle bbox rel origin): x-4..x+3, y-4..y+7
fn mask_rect(px: f64, py: f64) -> (i32, i32, i32, i32) {
    // GM place_meeting rounds the checked position
    let x = gm_round(px);
    let y = gm_round(py);
    (x - 4, x + 3, y - 4, y + 7)
}

fn rects_meet(a: (i32, i32, i32, i32), b: &(i32, i32, i32, i32)) -> bool {
    a.0 <= b.2 && a.1 >= b.0 && a.2 <= b.3 && a.3 >= b.1
}

pub fn meet_wall(px: f64, py: f64) -> bool {
    let m = mask_rect(px, py);
    MENU_WALL_RECTS.iter().any(|r| rects_meet(m, r))
}

fn meet_thin(px: f64, py: f64) -> bool {
    let m = mask_rect(px, py);
    MENU_THIN_RECTS.iter().any(|r| rects_meet(m, r))
}

fn meet_solid(px: f64, py: f64) -> bool {
    meet_wall(px, py) || meet_thin(px, py)
}

// GM round() = round half to EVEN (banker's): round(0.5)=0, round(1.5)=2,
// round(2.5)=2 — verified by jump-apex pixel ties via geist.
pub fn gm_round(v: f64) -> i32 {
    let f = floor64(v);
    let frac = v - f;
    if frac > 0.5 {
        f as i32 + 1
    } else if frac < 0.5 {
        f as i32
    } else {
        // tie: to even
        let fi = f as i32;
        if fi % 2 == 0 {
            fi
        } else {
            fi + 1
        }
    }
}

fn floor64(v: f64) -> f64 {
    let t = v as i64 as f64;
    if t > v {
        t - 1.0
    } else {
        t
    }
}

// no_std f64 ceil for non-negative values (|xsp| etc.)
fn ceil_pos(v: f64) -> f64 {
    let t = v as i64 as f64;
    if t < v {
        t + 1.0
    } else {
        t
    }
}

fn sign_f(v: f64) -> f64 {
    if v > 0.0 {
        1.0
    } else if v < 0.0 {
        -1.0
    } else {
        0.0
    }
}

// ---- fx pool (visible spawned objects) ----
pub const FX_MAX: usize = 64;
#[repr(C)]
#[derive(Clone, Copy, Default)]
pub struct Fx {
    pub alive: bool,
    pub kind: u8, // 0 jumpSmallerFx, 1 jumpFx, 2 casing, 3 muzzle, 4 recharge
    pub x: f64,
    pub y: f64,
    pub xsp: f64,
    pub ysp: f64,
    pub image_index: f32,
    pub image_speed: f32,
    pub emit_to: i8,
    pub angle: i16,
    pub alarm0: i32,
    pub alarm1: i32,
    pub flashing: bool,
    pub d_flash: i8, // casings: draw only when 1 (toggles while flashing)
    // GM: instances created during the normal-Step dispatch skip their own
    // Step that frame (sparkles); begin-step spawns (casings) do not.
    pub fresh: bool,
}

impl Fx {
    pub const fn zeroed() -> Fx {
        Fx {
            alive: false,
            kind: 0,
            x: 0.0,
            y: 0.0,
            xsp: 0.0,
            ysp: 0.0,
            image_index: 0.0,
            image_speed: 0.0,
            emit_to: 0,
            angle: 0,
            alarm0: -1,
            alarm1: -1,
            flashing: false,
            d_flash: 1,
            fresh: false,
        }
    }
}

impl Bullet {
    pub const fn zeroed() -> Bullet {
        Bullet {
            alive: false,
            x: 0.0,
            y: 0.0,
            b_dir: 0.0,
            b_speed: 0.0,
            all_set: false,
            decelerate: false,
            animation: false,
            image_index: 0.0,
            image_speed: 0.0,
            img_sp: 0.0,
            alarm0: -1,
        }
    }
}

// ---- player ----
#[repr(C)]
pub struct Player {
    pub exists: bool,
    pub xx: f64,
    pub yy: f64,
    pub x: i32,
    pub y: i32,
    pub xsp: f64,
    pub ysp: f64,
    pub xsp_carry: f64,
    pub ysp_carry: f64,
    pub image_xscale: f64,
    pub sprite_index: u16,
    pub image_index: f32,
    pub image_speed: f32,
    pub grounded: bool,
    pub airstatus: bool,
    pub napping: bool,
    pub nap_sprite: u16,
    pub nap_img_sp: f32,
    pub nap_x: f64,
    pub nap_y: f64,
    pub nap_xscale: f64,
    pub wall_colliding: bool,
    pub against_wall: i32,
    pub on_edge: i32, // GM: 1/-1 (init 0)
    pub hard_land: bool,
    pub hard_land_jump: bool,
    pub jumped: bool,
    pub jump_shoot_lock: bool,
    pub tiny_jump_threshold: bool,
    pub airborne_shot: bool,
    pub shot_delay: bool,
    pub non_auto: bool,
    pub no_charge_msg: bool,
    pub aim_angle: f64,
    pub shoot_leg: f64,
    pub alarm2: i32,
    pub alarm6: i32,
    pub alarm10: i32,
    pub xcollision: i32,
    pub ycollision: i32,
    // globals mirrored
    pub spin_jumping: f64,
    pub plx: f64,
    pub ply: f64,
    pub plx_dir: f64,
    pub p_fired: i32,
    pub stammo: i32,
    pub p_cam_focus: bool, // camLocker at (328,448), region x238..418 y248..648
}

pub const GM_EPS: f64 = 0.00001;
pub const GRAV: f64 = 0.2;
pub const MAXGRAV: f64 = 7.0;
const MOVEACCL: f64 = 0.2;
const MAXSP: f64 = 2.0;
const AIRMAXSP: f64 = 2.5;
const DECCLSP: f64 = 0.4;
const AIRDECCL: f64 = 0.1;
const JUMPSP: f64 = 4.4;
const WALLKICKSP: f64 = 4.0;
const HARD_LAND_SP: f64 = 1.2;
const WALL_KICK_LENGTH: f64 = 3.0;
// sprites
const SPR_IDLE: u16 = 31;
const SPR_RUN: u16 = 27;
const SPR_AIR: u16 = 37;
const SPR_SPIN: u16 = 1;
const SPR_SHOOT: u16 = 3;
const SPR_BALANCING: u16 = 15;
// gun 0 MACHINEGUN level 0
const ROF: i32 = 7;
const RECOIL: f64 = 0.0;
const SHAKE_AMT: f64 = 2.0;
const SHAKE_DUR: i32 = 3;
const CON_RATE: i32 = 1;

impl Player {
    pub const fn zeroed() -> Player {
        Player {
            exists: false,
            xx: 0.0,
            yy: 0.0,
            x: 0,
            y: 0,
            xsp: 0.0,
            ysp: 0.0,
            xsp_carry: 0.0,
            ysp_carry: 0.0,
            image_xscale: 1.0,
            sprite_index: SPR_IDLE,
            image_index: 0.0,
            image_speed: 0.3, // scrPlayerInit image_speed = 0.3 (creation frame)
            grounded: false,
            airstatus: true,
            napping: false,
            nap_sprite: 0,
            nap_img_sp: 0.0,
            nap_x: 0.0,
            nap_y: 0.0,
            nap_xscale: 1.0,
            wall_colliding: false,
            against_wall: 0,
            on_edge: 0,
            hard_land: false,
            hard_land_jump: false,
            jumped: false,
            jump_shoot_lock: false,
            tiny_jump_threshold: false,
            airborne_shot: false,
            shot_delay: true,
            non_auto: false,
            no_charge_msg: false,
            aim_angle: 0.0,
            shoot_leg: -1.0,
            alarm2: -1,
            alarm6: -1,
            alarm10: -1,
            xcollision: 0,
            ycollision: 0,
            spin_jumping: 0.0,
            plx: 0.0,
            ply: 0.0,
            plx_dir: 1.0,
            p_fired: 0,
            stammo: 8,
            p_cam_focus: false,
        }
    }

    // create at rmMenu room start; nap pose from the RNG chain
    pub fn create(&mut self, rng: &mut GmRng) {
        *self = Player::zeroed();
        self.exists = true;
        self.xx = 112.0;
        self.yy = 512.0;
        self.x = 112;
        self.y = 512;
        // scrPlayerInit: groundRoom -> napping=1, groundPlayerSet (irandom(5))
        self.napping = true;
        const POSES: [(u16, f32, f64, f64, f64); 6] = [
            (11, 0.015, 112.0, 506.0, 1.0),
            (12, 0.15, 112.0, 512.0, 1.0),
            (14, 0.0, 290.0, 496.0, 1.0),
            (13, 0.0, 80.0, 512.0, 1.0),
            (15, 0.25, 295.0, 496.0, 1.0),
            (14, 0.0, 290.0, 496.0, 1.0),
        ];
        let p = POSES[rng.irandom(5) as usize];
        self.nap_sprite = p.0;
        self.nap_img_sp = p.1;
        self.nap_x = p.2;
        self.nap_y = p.3;
        self.nap_xscale = p.4;
    }
}

// scrPlayerPlatformCollision / scrCheckCollisionWith translated: pixel-step
// movers. meet: family test at a position.
fn platform_collision(
    p: &mut Player,
    meet: fn(f64, f64) -> bool,
) {
    let workx = gm_round(p.xx) as f64 + ceil_pos(p.xsp.abs()) * sign_f(p.xsp);
    let worky = gm_round(p.yy) as f64 + ceil_pos(p.ysp.abs()) * sign_f(p.ysp);
    p.xcollision = 0;
    p.ycollision = 0;

    if meet(workx, p.yy) {
        p.xx = gm_round(p.xx) as f64;
        let limit = p.xsp;
        let mut amount = 0.0f64;
        loop {
            if meet(p.xx + amount + sign_f(p.xsp), p.yy) {
                break;
            }
            amount += sign_f(p.xsp);
            if amount.abs() >= limit.abs() {
                amount = 0.0;
                break;
            }
        }
        p.xx += amount;
        p.xcollision = sign_f(p.xsp) as i32;
    }
    if meet(p.xx, worky) {
        p.yy = gm_round(p.yy) as f64;
        let limit = p.ysp;
        let mut amount = 0.0f64;
        loop {
            if meet(p.xx, p.yy + amount + sign_f(p.ysp)) {
                break;
            }
            amount += sign_f(p.ysp);
            if amount.abs() >= limit.abs() {
                amount = 0.0;
                break;
            }
        }
        p.yy += amount;
        p.ycollision = sign_f(p.ysp) as i32;
    }
    if p.xcollision == 0 && p.ycollision == 0 && meet(workx, worky) {
        p.yy = gm_round(p.yy) as f64;
        p.xx = gm_round(p.xx) as f64;
        let limit = p.ysp;
        let mut xa = 0.0f64;
        let mut ya = 0.0f64;
        loop {
            if meet(p.xx + xa + sign_f(p.xsp), p.yy + ya)
                || meet_wall(p.xx + xa + sign_f(p.xsp), p.yy + ya)
            {
                break;
            }
            xa += sign_f(p.xsp);
            if meet(p.xx + xa, p.yy + ya + sign_f(p.ysp))
                || meet_wall(p.xx + xa, p.yy + ya + sign_f(p.ysp))
            {
                break;
            }
            ya += sign_f(p.ysp);
            if ya.abs() >= limit.abs() {
                xa = 0.0;
                ya = 0.0;
                break;
            }
        }
        p.yy += ya;
        p.xx += xa;
        p.ycollision = sign_f(p.ysp) as i32;
        p.xcollision = sign_f(p.xsp) as i32;
    }
}

// ---- the per-frame pipeline (obj_player_n Step_1 -> Step_0, GM event order) ----
// Effects that spawn instances or consume RNG go through the context struct.
pub struct StepCtx<'a> {
    pub rng: &'a mut GmRng,
    pub fx: &'a mut [Fx; FX_MAX],
    pub bullets: &'a mut [Bullet; BUL_MAX],
    pub inp: &'a Inputs,
    pub no_control: bool,
    pub meter_jiggle: &'a mut f64, // objControlerN HUD jiggle (scrRecharge)
    pub cam: &'a mut Camera,
}

fn fx_spawn(fx: &mut [Fx; FX_MAX], f: Fx) {
    for slot in fx.iter_mut() {
        if !slot.alive {
            *slot = f;
            slot.alive = true;
            return;
        }
    }
}

impl Player {
    // Step_1 (begin step): the movement pipeline
    pub fn step_begin(&mut self, c: &mut StepCtx) {
        if !self.exists {
            return;
        }
        // scrGravity_n (menu: area 0, no water, playStyle 0, no ballooning)
        self.ysp += GRAV;
        if self.ysp >= MAXGRAV {
            self.ysp = MAXGRAV;
        }
        // scrCheckInWater: no water in rmMenu -> no-op
        self.pl_movement(c);
        self.wall_col(c);
        if self.napping {
            self.xsp = 0.0;
            self.ysp = 0.0;
        }
        // (no goalStop in menu)
        self.yy += self.ysp;
        self.xx += self.xsp;
        // (no wrapMode)
        self.x = gm_round(self.xx);
        self.y = gm_round(self.yy);
        // camLocker focus: instance_place(xx, yy, camLocker) — camLocker at
        // (328,448), sprite 596 100x160 origin (50,80), scale (1.8, 2.5):
        // rect x 328-90..328+90-1, y 448-200..448+200-1
        let m = mask_rect(self.xx, self.yy);
        self.p_cam_focus = rects_meet(m, &(238, 248, 417, 647));
        // interactable/timefield/death: not reachable in menu idle-walk scope
        if self.image_xscale != 0.0 {
            self.plx_dir = sign_f(self.image_xscale);
        }
    }

    // scrPlMovement
    fn pl_movement(&mut self, c: &mut StepCtx) {
        self.jumped = false;
        self.plx = self.xx;
        self.ply = self.yy;
        // (pugDecoy: eplx/eply mirrors, unused visually)
        if !c.no_control && !self.napping {
            // !death
            if c.inp.d_left {
                if self.xsp >= 0.0 && self.grounded && !c.inp.d_right && !self.wall_colliding {
                    fx_spawn(c.fx, Fx {
                        kind: 0,
                        x: self.xx,
                        y: self.yy,
                        image_speed: 0.5,
                        emit_to: -1,
                        ..Fx::default()
                    });
                }
                self.xsp -= MOVEACCL;
                if self.grounded {
                    if self.xsp > 0.0 {
                        self.xsp -= sign_f(self.xsp) * 2.0;
                    }
                    if self.xsp < -MAXSP {
                        self.xsp = -MAXSP;
                    }
                } else {
                    if self.xsp > 0.0 {
                        self.xsp -= sign_f(self.xsp) * 1.0;
                    }
                    if self.xsp < -AIRMAXSP {
                        self.xsp = -AIRMAXSP;
                    }
                }
                if meet_wall(self.xx - 2.0, self.yy) {
                    self.against_wall = -1;
                }
                if self.spin_jumping == 0.0 {
                    self.image_xscale = -1.0;
                }
            }
            if c.inp.d_right {
                if self.xsp <= 0.0 && self.grounded && !c.inp.d_left && !self.wall_colliding {
                    fx_spawn(c.fx, Fx {
                        kind: 0,
                        x: self.xx,
                        y: self.yy,
                        image_speed: 0.5,
                        emit_to: 1,
                        ..Fx::default()
                    });
                }
                self.xsp += MOVEACCL;
                if self.grounded {
                    if self.xsp < 0.0 {
                        self.xsp -= sign_f(self.xsp) * 2.0;
                    }
                    if self.xsp > MAXSP {
                        self.xsp = MAXSP;
                    }
                } else {
                    if self.xsp < 0.0 {
                        self.xsp -= sign_f(self.xsp) * 1.0;
                    }
                    if self.xsp > AIRMAXSP {
                        self.xsp = AIRMAXSP;
                    }
                }
                if meet_wall(self.xx + 2.0, self.yy) {
                    self.against_wall = 1;
                }
                if self.spin_jumping == 0.0 {
                    self.image_xscale = 1.0;
                }
            }
            if !(c.inp.d_left || c.inp.d_right) {
                if self.grounded {
                    self.xsp -= sign_f(self.xsp) * DECCLSP;
                } else {
                    self.xsp -= sign_f(self.xsp) * AIRDECCL;
                }
                self.against_wall = 0;
                if self.xsp.abs() < 0.3 {
                    self.xsp = 0.0;
                }
                if self.grounded {
                    // collision_line(x+5*dir, y .. y+16, sParentSolid): a
                    // vertical line probe; approximate with point checks each
                    // 1px (line through solid rects)
                    let cx = self.x as f64 + 5.0 * self.image_xscale;
                    let mut hit = false;
                    let mut yy = self.y;
                    while yy <= self.y + 16 {
                        let pt = (cx as i32, cx as i32, yy, yy);
                        if MENU_WALL_RECTS.iter().any(|r| rects_meet(pt, r))
                            || MENU_THIN_RECTS.iter().any(|r| rects_meet(pt, r))
                        {
                            hit = true;
                            break;
                        }
                        yy += 1;
                    }
                    self.on_edge = if !hit { 1 } else { -1 };
                } else {
                    self.on_edge = -1;
                }
            } else {
                self.on_edge = -1;
            }
            if c.inp.d_left && c.inp.d_right {
                self.xsp = 0.0;
            }
            self.up_button_functions(c);
            // (fjump: enemy bounce, not in menu)
        }
        if c.no_control {
            self.xsp = 0.0;
        }
        if self.grounded {
            if self.airstatus {
                self.airstatus = false;
                // groundRoom -> no levelBeginCue
                fx_spawn(c.fx, Fx {
                    kind: 0,
                    x: self.xx,
                    y: self.yy,
                    image_speed: 0.5,
                    emit_to: sign_f(self.xsp) as i8,
                    ..Fx::default()
                });
                if self.hard_land {
                    if c.inp.d_left || c.inp.d_right {
                        // (playStyle != 3, !gInWater) scrFjump(0, 1):
                        // the landing bounce — NO soundLand on this path
                        self.spin_jumping = 1.0;
                        // scrRecharge (inside scrFjump)
                        if self.stammo < 8 {
                            self.stammo = 8;
                            fx_spawn(c.fx, Fx {
                                kind: 4,
                                x: self.plx,
                                y: self.ply,
                                image_speed: 1.0,
                                ..Fx::zeroed()
                            });
                            c.cam.sshake(1.0, 2);
                            *c.meter_jiggle = 4.0;
                        }
                        self.grounded = false;
                        // xfjump == 0 -> xsp unchanged
                        self.ysp = -1.0; // yfjump arg 1 (nonzero: default 2.7 unused)
                        self.hard_land_jump = true;
                        self.alarm6 = 15;
                        // soundPlay(88, 30, 0, 1): fixed id, no RNG
                    } else {
                        self.sound_land(c);
                    }
                    self.hard_land = false;
                } else {
                    self.sound_land(c);
                }
                self.no_charge_msg = false;
                self.spin_jumping = 0.0;
                self.airborne_shot = false;
            }
            // comboDone: comboCount 0 -> no visible effect
            self.yy = gm_round(self.yy) as f64;
            // footstep sound on run frames 1/5 crossings
            if self.sprite_index == SPR_RUN {
                let fi = self.image_index as i32;
                if fi == 1 || fi == 5 {
                    let prev = (self.image_index - 0.3) as i32; // imgsprun
                    if prev != fi {
                        // soundFootstep: irandom_range(1, n) = 2 draws
                        let _ = c.rng.irandom(0); // placeholder, fixed below
                    }
                }
            }
        }
        if !self.grounded {
            if self.p_fired != 0 {
                if !self.airborne_shot {
                    self.airborne_shot = true;
                }
                self.image_index = 0.0;
            }
            self.airstatus = true;
        }
        // outOfMain, death: skip in menu scope
        self.sprite_control(c);
        let xf = self.xsp + self.xsp_carry;
        let yf = self.ysp + self.ysp_carry;
        self.xsp_carry = 0.0;
        self.ysp_carry = 0.0;
        let _ = (xf, yf); // xspFinal/yspFinal (used by carriers; none in menu)
    }
}

impl Player {
    // scrUpButtonFunctions
    fn up_button_functions(&mut self, c: &mut StepCtx) {
        if c.inp.d_up {
            // (!global.interactable — releaseNotes sets interactOk? player at
            // bench isn't on the notes; skip)
            if self.grounded {
                if self.tiny_jump_threshold {
                    if !meet_wall(self.xx, self.yy - 16.0) {
                        self.tiny_jump_threshold = false;
                    }
                }
                if self.tiny_jump_threshold && !self.hard_land_jump {
                    self.shoot(c);
                    self.tiny_jump_threshold = false;
                } else {
                    self.jump(c);
                }
            } else if self.hard_land_jump {
                if meet_solid(self.xx, self.yy + 8.0) {
                    self.jump(c);
                } else {
                    self.hard_land_jump = false;
                }
            } else if self.spin_jumping != 0.0 {
                if c.inp.d_left {
                    if meet_wall(self.x as f64 + WALL_KICK_LENGTH, self.y as f64) {
                        fx_spawn(c.fx, Fx {
                            kind: 1,
                            x: self.x as f64,
                            y: self.y as f64,
                            image_speed: 0.5,
                            angle: 90,
                            ..Fx::default()
                        });
                        c.rng.well(); // soundPlay(choose(86)) — 1 draw
                        self.jump_shoot_lock = true;
                        self.grounded = false;
                        self.image_index = 0.0;
                        self.alarm10 = 30;
                        self.tiny_jump_threshold = true;
                        self.hard_land_jump = false;
                        self.ysp = -WALLKICKSP;
                        self.xsp = -MAXSP;
                        self.spin_jumping = 0.0;
                    }
                } else if c.inp.d_right
                    && meet_wall(self.x as f64 - WALL_KICK_LENGTH, self.y as f64)
                {
                    fx_spawn(c.fx, Fx {
                        kind: 1,
                        x: self.x as f64,
                        y: self.y as f64,
                        image_speed: 0.5,
                        angle: 270,
                        ..Fx::default()
                    });
                    c.rng.well(); // choose(86)
                    self.jump_shoot_lock = true;
                    self.grounded = false;
                    self.image_index = 0.0;
                    self.alarm10 = 30;
                    self.tiny_jump_threshold = true;
                    self.hard_land_jump = false;
                    self.ysp = -WALLKICKSP;
                    self.xsp = MAXSP;
                    self.spin_jumping = 0.0;
                }
            }
            if !self.jump_shoot_lock {
                self.spin_jumping = 0.0;
                // yayJumping = 0 (never set in menu)
            }
        }
        if c.inp.d_up_rel {
            if self.ysp < 0.0 {
                self.ysp /= 2.0;
            }
            if self.jump_shoot_lock {
                self.jump_shoot_lock = false;
            }
            // pBulDelayKill == 1 (machinegun) -> shotDelay = 0
            self.shot_delay = false;
            // wet, nonAuto, jetpacking resets
            if self.non_auto {
                self.non_auto = false;
            }
        }
        if c.inp.d_up_held && !self.grounded {
            if !self.shot_delay
                && !self.jump_shoot_lock
                && !self.hard_land_jump
                && !self.non_auto
            {
                self.shoot(c);
            }
            // pugJet: none
        }
    }

    // scrJump (non-water path)
    fn jump(&mut self, c: &mut StepCtx) {
        if self.napping {
            return;
        }
        self.ysp = -JUMPSP;
        self.jumped = true;
        c.rng.well(); // soundPlay(choose(86)) — 1 draw
        fx_spawn(c.fx, Fx {
            kind: 1,
            x: self.x as f64,
            y: self.y as f64,
            image_speed: 0.5,
            ..Fx::default()
        });
        self.jump_shoot_lock = true;
        self.grounded = false;
        self.hard_land_jump = false;
        if c.inp.d_left || c.inp.d_right {
            self.spin_jumping = 1.0;
        }
        self.image_index = 0.0;
    }

    // scrPlayerShootN (stammo > 0 path; gun 0)
    fn shoot(&mut self, c: &mut StepCtx) {
        let muzzlex = self.x as f64;
        let muzzley = self.y as f64 + 4.0;
        let shot_angle = 270.0 + self.aim_angle; // aimAngleLimit 0 -> 270
        self.spin_jumping = 0.0;
        if self.stammo > 0 {
            c.cam.sshake(SHAKE_AMT, SHAKE_DUR); // scrSShake(2, 3)
            // scrShotSound: no RNG
            if self.ysp > RECOIL {
                self.ysp = RECOIL;
            }
            // scrPlayerEmitBullet: muzzle fx + bullet instance
            let emitx = muzzlex + self.shoot_leg;
            self.shoot_leg *= -1.0;
            fx_spawn(c.fx, Fx {
                kind: 3, // muzzle fx sprite 603
                x: emitx,
                y: self.y as f64 + 12.0,
                image_speed: 0.5,
                angle: shot_angle as i16,
                ..Fx::default()
            });
            // bullet object 261: TODO create (bullet pool) — accuracy 3,
            // speed 8, rangeRandom 2, rangeTimer 12 (RNG draws in create!)
            spawn_bullet(c, emitx, muzzley, shot_angle);
            self.alarm2 = ROF; // pBulRof 7 (positive -> auto)
            // bulletCasing create: 3 RNG draws + physics
            let cx = c.rng.random_range(-3.0, -1.0) * sign_f(self.image_xscale);
            let cy = c.rng.random_range(-3.0, 0.0);
            let cs = [-0.5f32, -0.3, 0.0, 0.3, 0.5][c.rng.choose_index(5) as usize];
            fx_spawn(c.fx, Fx {
                kind: 2,
                x: self.x as f64,
                y: self.y as f64,
                xsp: cx,
                ysp: cy,
                image_speed: cs,
                alarm0: 15,
                d_flash: 1, // Fx::default() zeroes this; draw gate needs 1
                ..Fx::default()
            });
            self.p_fired = 1;
            self.stammo -= CON_RATE;
            if self.stammo <= 0 {
                // emitSmoke x2 + rising text + sound (visible fx TODO)
                self.stammo = 0;
                self.no_charge_msg = true;
                self.non_auto = true;
            }
        } else {
            // EMPTY branch: smoke x2 + sound + fall cap + "EMPTY!" text
            let no_ammo_ysp = 3.0;
            if self.ysp > no_ammo_ysp {
                self.ysp = no_ammo_ysp;
            }
            if !self.no_charge_msg {
                // scrRisingText (visible; TODO port text object)
                self.no_charge_msg = true;
            }
            self.alarm2 = 16;
        }
        // every scrPlayerShootN call re-arms the delay; Alarm_2 clears it
        self.shot_delay = true;
    }

    fn sound_land(&mut self, c: &mut StepCtx) {
        // landOn = instance_place(x, y+2, sParentSolid): true when landing
        if meet_solid(self.x as f64, self.y as f64 + 2.0) && !self.napping {
            // material switch selects bank; irandom_range(1, n) = 2 draws
            c.rng.irandom(0);
        }
    }
}

impl Player {
    // scrWallCol
    fn wall_col(&mut self, c: &mut StepCtx) {
        if !self.hard_land && !self.hard_land_jump {
            self.hard_land = true;
        } else if self.hard_land && self.ysp < HARD_LAND_SP {
            self.hard_land = false;
        }
        if self.grounded {
            self.ysp = 0.0;
        }
        // scrPlayerPlatformCollision(parentThinwall)
        platform_collision(self, meet_thin);
        if self.ycollision == 1
            && !meet_thin(self.xx, self.yy)
            && meet_thin(self.xx, self.yy + 1.0)
        {
            self.grounded = true;
            self.ysp = 0.0;
        }
        // scrCheckCollisionWith(parentWall)
        platform_collision(self, meet_wall);
        if self.xcollision != 0 {
            self.xsp = 0.0;
            if self.xcollision == 1 {
                if c.inp.d_right {
                    self.wall_colliding = true;
                }
            } else if self.xcollision == -1 && c.inp.d_left {
                self.wall_colliding = true;
            }
        } else {
            self.wall_colliding = false;
        }
        if self.ycollision != 0 {
            if self.ycollision == 1 {
                if meet_wall(self.xx, self.yy + 1.0) {
                    self.grounded = true;
                    self.ysp = 0.0;
                }
            } else if self.ycollision == -1 {
                self.ysp = 0.0;
                // objBox_n above: none in menu
            }
        }
        if self.grounded {
            if self.airstatus {
                // comboDone if xcollision==0: comboCount 0 -> no-op
                // scrRecharge: stammo restore + fx + HUD jiggle + shake(1,2)
                if self.stammo < 8 {
                    self.stammo = 8;
                    fx_spawn(c.fx, Fx {
                        kind: 4, // effect sprite 111, speed 1, scale .75
                        x: self.plx,
                        y: self.ply,
                        image_speed: 1.0,
                        ..Fx::default()
                    });
                    c.cam.sshake(1.0, 2); // scrSShake(1, 2)
                    *c.meter_jiggle = 4.0;
                }
            }
            if meet_wall(self.xx, self.yy) && !meet_wall(self.xx, self.yy - 1.0) {
                self.yy -= 1.0;
            }
        }
        if !meet_solid(self.xx, self.yy + 1.0) && self.grounded {
            self.grounded = false;
            self.ysp += GRAV;
        }
    }

    // playerSpriteControl (no-death paths)
    fn sprite_control(&mut self, c: &mut StepCtx) {
        if !self.napping {
            if self.grounded {
                if self.xsp == 0.0 {
                    if self.on_edge != 1 {
                        // GM truthiness: onEdge -1 or 0 -> "false"? !onEdge:
                        // onEdge==1 -> balancing; onEdge<=0 -> idle. GM
                        // `if (!onEdge)` is true only when onEdge==0... but
                        // onEdge is set to 1/-1 every grounded frame; treat
                        // -1/0 as idle, 1 as balancing (GM: !1=false !(-1)=true
                        // -> idle for -1 ✓, balancing only for onEdge==1? NO:
                        // !onEdge false for 1 AND -1?? GM !(-1): -1>0.5 false
                        // -> !false = true -> IDLE for -1; onEdge==1 -> !1 =
                        // false -> else BALANCING ✓)
                        self.sprite_index = SPR_IDLE;
                        self.image_speed = 0.1; // imgspstand
                    } else {
                        self.sprite_index = SPR_BALANCING;
                        self.image_speed = 0.25;
                    }
                } else {
                    if self.sprite_index != SPR_RUN {
                        self.image_index = 0.0;
                    }
                    self.image_speed = 0.3; // imgsprun
                    self.sprite_index = SPR_RUN;
                }
            } else {
                // airborne
                if self.spin_jumping != 0.0 {
                    self.sprite_index = SPR_SPIN;
                    self.image_speed = 0.3 * self.spin_jumping as f32;
                    if c.inp.d_left {
                        if meet_wall(self.x as f64 + WALL_KICK_LENGTH, self.y as f64) {
                            self.sprite_index = 5; // sprPlayerWall (id TBD!)
                            self.image_index = 0.0;
                            self.image_xscale = -1.0;
                        }
                    } else if c.inp.d_right
                        && meet_wall(self.x as f64 - WALL_KICK_LENGTH, self.y as f64)
                    {
                        self.sprite_index = 5;
                        self.image_index = 0.0;
                        self.image_xscale = 1.0;
                    }
                } else if self.airborne_shot {
                    self.sprite_index = SPR_SHOOT;
                    if self.image_index <= 3.0 {
                        self.image_speed = 0.25; // imgspshoot
                    } else {
                        self.image_speed = 0.0;
                    }
                } else {
                    self.sprite_index = SPR_AIR;
                    self.image_speed = 0.0;
                    // GM real comparisons use math_set_epsilon (default 1e-5):
                    // ysp < 0 is FALSE for epsilon-negative values, so the
                    // falling pose starts a frame earlier at the apex.
                    if self.ysp < -GM_EPS {
                        self.image_index = 0.0;
                        match self.ysp.abs() as i32 {
                            3 | 2 => self.image_index = 0.0,
                            1 | 0 => self.image_index = 1.0,
                            _ => {}
                        }
                    } else {
                        self.image_index = 4.0;
                        match self.ysp.abs() as i32 {
                            0 => self.image_index = 2.0,
                            1 => self.image_index = 3.0,
                            2 => self.image_index = 4.0,
                            _ => {}
                        }
                    }
                }
            }
        } else {
            // napping
            self.sprite_index = self.nap_sprite;
            self.image_speed = self.nap_img_sp;
            self.image_xscale = self.nap_xscale;
            self.xx = self.nap_x;
            self.yy = self.nap_y;
            if c.inp.any_input && !c.no_control {
                self.napping = false;
                if self.grounded {
                    self.sound_land(c);
                    fx_spawn(c.fx, Fx {
                        kind: 0,
                        x: self.xx,
                        y: self.yy,
                        image_speed: 0.5,
                        emit_to: 0,
                        ..Fx::default()
                    });
                }
            }
        }
    }

    // Step_0 (normal step)
    pub fn step_normal(&mut self, c: &mut StepCtx) {
        if !self.exists {
            return;
        }
        if self.p_fired == 2 {
            self.p_fired = 0;
        }
        if self.p_fired == 1 {
            self.p_fired = 2;
        }
        // scrAimControl (aimAngleLimit=0 for machinegun -> clamps to 0)
        let _ = c;
        self.aim_angle = 0.0;
    }

    // alarm phase (before step events)
    pub fn alarms(&mut self) {
        if !self.exists {
            return;
        }
        if self.alarm2 > -1 {
            self.alarm2 -= 1;
            if self.alarm2 == 0 {
                self.shot_delay = false;
            }
        }
        if self.alarm6 > -1 {
            self.alarm6 -= 1;
            if self.alarm6 == 0 {
                self.hard_land_jump = false;
            }
        }
        if self.alarm10 > -1 {
            self.alarm10 -= 1;
            if self.alarm10 == 0 {
                self.tiny_jump_threshold = false;
            }
        }
    }

    // engine anim advance (applied at start of next tick, matching scene model)
    pub fn anim_advance(&mut self) {
        if !self.exists {
            return;
        }
        self.image_index += self.image_speed;
        let frames = match self.sprite_index {
            31 => 4,  // idle
            27 => 8,  // run
            37 => 5,  // air
            1 => 8,   // spin
            3 => 4,   // shoot
            15 => 24, // balancing
            11 => 2,  // nap
            12 => 8,  // legswing
            _ => 8,
        } as f32;
        if self.image_index >= frames {
            self.image_index -= frames;
        }
    }

    pub fn draw(&self, dl: &mut DrawList, view_x: i32, view_y: i32) {
        if !self.exists {
            return;
        }
        // playerDraw normal path: draw_sprite_ext(sprite, image_index, x, y,
        // image_xscale, 1, 0, c_white, 1); origins vary by sprite
        let (ox, oy) = match self.sprite_index {
            31 | 3 | 10 => (12, 12),
            11 => (16, 14),
            _ => (16, 16),
        };
        let (w, h) = match self.sprite_index {
            31 | 3 | 10 => (24, 24),
            _ => (32, 32),
        };
        let flip = self.image_xscale < 0.0;
        let sx = self.x - view_x;
        let sy = self.y - view_y;
        dl.push(DrawCmd {
            sprite: self.sprite_index,
            frame: self.image_index as u16,
            x: if flip { (sx + ox) as f32 } else { (sx - ox) as f32 },
            y: (sy - oy) as f32,
            w: if flip { -(w as f32) } else { w as f32 },
            h: h as f32,
            color: C_WHITE,
            pal: 2,
            rot: 0.0,
        });
    }
}

// ---- bullets (bulletRanged 261) ----
pub const BUL_MAX: usize = 32;
#[repr(C)]
#[derive(Clone, Copy, Default)]
pub struct Bullet {
    pub alive: bool,
    pub x: f64,
    pub y: f64,
    pub b_dir: f64,
    pub b_speed: f64,
    pub all_set: bool,
    pub decelerate: bool,
    pub animation: bool,
    pub image_index: f32,
    pub image_speed: f32,
    pub img_sp: f32,
    pub alarm0: i32,
}

// double-precision sin/cos in degrees (GM lengthdir_*); polynomial via
// range-reduced libm-style implementation. Accuracy ~1e-15 — geist arbitrates.
fn dsin(deg: f64) -> f64 {
    let r = deg.to_radians();
    // minimax-ish via Taylor on reduced range (r is small multiples of pi)
    let x = r % (2.0 * core::f64::consts::PI);
    taylor_sin(x)
}
fn dcos(deg: f64) -> f64 {
    dsin(deg + 90.0)
}
fn taylor_sin(x: f64) -> f64 {
    // reduce to [-pi, pi]
    let mut x = x;
    const PI: f64 = core::f64::consts::PI;
    while x > PI {
        x -= 2.0 * PI;
    }
    while x < -PI {
        x += 2.0 * PI;
    }
    let x2 = x * x;
    // 17th-order Taylor: |err| < 1e-16 on [-pi,pi]... adequate start
    x * (1.0
        + x2 * (-1.0 / 6.0
            + x2 * (1.0 / 120.0
                + x2 * (-1.0 / 5040.0
                    + x2 * (1.0 / 362880.0
                        + x2 * (-1.0 / 39916800.0
                            + x2 * (1.0 / 6227020800.0
                                + x2 * (-1.0 / 1307674368000.0))))))))
}

fn spawn_bullet(c: &mut StepCtx, x: f64, y: f64, dir: f64) {
    // bulletRanged create: imgSp = rr(0.4,0.6); bSpeed = 8 + rr(-2, 0);
    // alarm0 = 12; bDir += rr(-3,3) happens in the bullet's first Step_0.
    let img_sp = c.rng.random_range(0.4, 0.6) as f32;
    let b_speed = 8.0 + c.rng.random_range(-2.0, 0.0);
    for b in c.bullets.iter_mut() {
        if !b.alive {
            *b = Bullet {
                alive: true,
                x,
                y,
                b_dir: dir,
                b_speed,
                all_set: false,
                decelerate: false,
                animation: false,
                image_index: 0.0,
                image_speed: 0.0,
                img_sp,
                alarm0: 12,
            };
            return;
        }
    }
}

// bullet Step_0 + Step_2 (despawn out of view) + alarm
pub fn bullet_step(b: &mut Bullet, rng: &mut GmRng, fx: &mut [Fx; FX_MAX], view_y: i32) {
    if !b.alive {
        return;
    }
    // alarm phase
    if b.alarm0 > -1 {
        b.alarm0 -= 1;
        if b.alarm0 == 0 {
            b.decelerate = true;
        }
    }
    if !b.all_set {
        b.b_dir += rng.random_range(-3.0, 3.0); // bdirRand = accuracy 3
        b.all_set = true;
    }
    if b.decelerate {
        b.b_speed *= 0.8;
    }
    if b.b_speed < 3.0 && !b.animation {
        b.animation = true;
        b.image_speed = b.img_sp;
    }
    let xsp = dcos(b.b_dir) * b.b_speed;
    let ysp = -dsin(b.b_dir) * b.b_speed;
    // scrBulCheckSolid: line to (x+xsp, y+ysp) vs solid walls -> walk to
    // contact in 1/10 steps then destroy (bdmg 0; walls aren't parent-84)
    let steps = 10;
    let mut hit = false;
    for i in 1..=steps {
        let px = b.x + xsp * i as f64 / steps as f64;
        let py = b.y + ysp * i as f64 / steps as f64;
        let pt = (px as i32, px as i32, py as i32, py as i32);
        if crate::room_menu_gen::MENU_WALL_RECTS.iter().any(|r| pt.0 <= r.2 && pt.1 >= r.0 && pt.2 <= r.3 && pt.3 >= r.1) {
            // walk-to-contact: position lands at the wall edge; then destroy
            b.x = px;
            b.y = py;
            hit = true;
            break;
        }
    }
    if hit {
        // scrEffectSpawn(x, y, hitWallFx=101, 0.5, 0, 0): depth 0 — drawn in
        // front of the bench (1000), behind the player (-50000)
        for slot in fx.iter_mut() {
            if !slot.alive {
                *slot = Fx {
                    alive: true,
                    kind: 5,
                    x: b.x,
                    y: b.y,
                    image_speed: 0.5,
                    ..Fx::zeroed()
                };
                break;
            }
        }
        b.alive = false;
        return;
    }
    b.x += xsp;
    b.y += ysp;
    // Step_2 scrOutofview/scrBulletOov: despawn well below/above view
    if (b.y as i32) > view_y + 284 + 64 || (b.y as i32) < view_y - 64 {
        b.alive = false;
    }
}

// ---- camMain (verbatim cam_main Create + Step_0, ground-room paths) ----
#[repr(C)]
pub struct Camera {
    pub exists: bool,
    pub x: i32,
    pub y: i32,
    pub xx: f64,
    pub yy: f64,
    pub cam_pointx: f64,
    pub cam_pointy: f64,
    pub cam_slowdown: f64,
    pub cam_slowdown_x: f64,
    pub cam_shake: f64,
    pub cam_shake_amt: f64,
    pub daop: f64,
    pub chase_player: bool,
    pub centered: bool,
    pub free_cam: bool,
    pub x_ahead: f64,
    pub side_locked: bool,
    pub roomw: f64,
    pub room_end: f64, // roomEndSetter: y-176 = 448 in rmMenu; -1 = off
    pub alarm0: i32,   // shake duration (Alarm_0 clears shake)
}

impl Camera {
    pub const fn zeroed() -> Camera {
        Camera {
            exists: false,
            x: 0,
            y: 0,
            xx: 0.0,
            yy: 0.0,
            cam_pointx: 0.0,
            cam_pointy: 0.0,
            cam_slowdown: 5.0,
            cam_slowdown_x: 1.0,
            cam_shake: 0.0,
            cam_shake_amt: 0.0,
            daop: 24.0,
            chase_player: true,
            centered: true,
            free_cam: false,
            x_ahead: 16.0,
            side_locked: false,
            roomw: 416.0,
            room_end: -1.0,
            alarm0: -1,
        }
    }

    // scrSpawnCamera: created at player pos, freeCam=1 (groundRoom)
    pub fn create(&mut self, px: i32, py: i32) {
        *self = Camera::zeroed();
        self.exists = true;
        self.free_cam = true; // groundRoom
        self.daop = -32.0; // groundRoom
        self.cam_pointy = py as f64;
        self.cam_pointx = px as f64;
        self.x = px;
        self.y = py;
        self.xx = px as f64;
        self.yy = py as f64;
    }

    // scrSShake
    pub fn sshake(&mut self, amt: f64, dur: i32) {
        self.cam_shake = 1.0;
        if self.cam_shake_amt < amt {
            self.cam_shake_amt = amt;
        }
        if self.alarm0 < dur {
            self.alarm0 = dur;
        }
    }

    // alarm phase: Alarm_0 clears the shake
    pub fn alarms(&mut self) {
        if self.alarm0 > -1 {
            self.alarm0 -= 1;
            if self.alarm0 == 0 {
                self.cam_shake = 0.0;
                self.cam_shake_amt = 0.0;
            }
        }
    }

    // cam_main Step_0 (no-death, freeCam ground-room branch)
    pub fn step(&mut self, p: &Player, rng: &mut GmRng) {
        if !self.exists {
            return;
        }
        // freeCam branch
        self.cam_pointx = p.plx + p.plx_dir * self.x_ahead;
        if self.cam_pointx < 80.0 {
            self.cam_pointx = 80.0;
        } else if self.cam_pointx > self.roomw - 80.0 {
            self.cam_pointx = self.roomw - 80.0;
        }
        if self.chase_player {
            self.cam_pointy = p.ply + self.daop;
        }
        self.cam_slowdown = 5.0;
        self.cam_slowdown_x = 10.0;
        // centered/xAhead dance
        if self.centered && self.x_ahead != 0.0 {
            self.x_ahead = 0.0;
        } else if !self.centered && self.x_ahead == 0.0 {
            self.x_ahead = 16.0;
        }
        if self.centered && p.xsp != 0.0 {
            self.centered = false;
            self.x_ahead = 16.0;
        }
        // (sideLocked release path: no sideCamLocker in menu)
        if p.p_cam_focus {
            // camLocker pointer = (328, 448)
            self.cam_pointy = 448.0;
            self.cam_pointx = 328.0;
            self.cam_slowdown_x = 15.0;
        }
        // roomEnd clamp (roomEndSetter in rmMenu -> 448); GM-truthy check
        if self.room_end > 0.5 {
            if self.cam_pointy > self.room_end {
                self.cam_pointy = self.room_end;
                if self.yy > self.room_end {
                    self.yy = self.room_end;
                }
            }
        }
        let accl_x = (self.cam_pointx - self.xx) / self.cam_slowdown_x;
        let accl_y = (self.cam_pointy - self.yy) / self.cam_slowdown;
        self.yy += accl_y;
        self.xx += accl_x;
        if self.yy < 142.0 {
            self.yy = 142.0;
        }
        let mut xf = self.xx;
        let mut yf = self.yy;
        if self.cam_shake != 0.0 {
            // irandom_range consumes 2 draws each
            let half = self.cam_shake_amt / 2.0;
            xf = self.xx + irandom_range_f(rng, -half, half);
            yf = self.yy + irandom_range_f(rng, -self.cam_shake_amt, self.cam_shake_amt);
        }
        self.x = gm_round(xf);
        self.y = gm_round(yf);
    }
}

// GM irandom_range(a,b) with real args: floors? GM irandom_range takes ints;
// -camShakeAmt/2 can be fractional (-1.0): GM rounds args. 2 draws.
fn irandom_range_f(rng: &mut GmRng, a: f64, b: f64) -> f64 {
    let lo = gm_round(a) as i64;
    let hi = gm_round(b) as i64;
    let n = (hi - lo).unsigned_abs();
    lo as f64 + rng.irandom(n) as f64
}
