// scrDrawHud4x3 port, idle-menu constants baked in:
// playerHp=4/4, heartPiece=0/4, currency=0, ammo=stammo=8, pBulConRate=2,
// meterJiggle=0, hudAmmoJiggle=0, chargeFrame[] steady at 3.8 (drawn as 3),
// showTimer=-1 (false), ugHave=0. Dynamic paths port with gameplay later.
use crate::{
    spr, sprite_ext, sprite_stretched, DrawCmd, DrawList, C_WHITE,
};

fn spr_at(dl: &mut DrawList, s: u16, frame: u16, x: i32, y: i32) {
    // draw_sprite with origin (0,0) sprites — all HUD parts below qualify,
    // except sprHudCurrency (origin 53,9) which goes through sprite_ext
    let (w, h) = crate::sprite_size(s);
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

// drawSpriteHP(x,y,_): "4/4" at smalx=x-4, smaly=y-5
fn draw_sprite_hp(dl: &mut DrawList, x: i32, y: i32) {
    let smalx = x - 4;
    let smaly = y - 5;
    // hp "4": HPx = smalx - 1*8 - 1
    let hpx = smalx - 8 - 1;
    // literal quadruple pattern from the GML
    spr_at(dl, spr::SPRITE_NUMBER, 4 + 20, hpx + 1, smaly);
    spr_at(dl, spr::SPRITE_NUMBER, 4 + 20, hpx + 1, smaly + 1);
    spr_at(dl, spr::SPRITE_NUMBER, 4 + 20, hpx, smaly + 1);
    spr_at(dl, spr::SPRITE_NUMBER, 4, hpx, smaly);
    // slash
    spr_at(dl, spr::SPRITE_SLASH, 2, smalx + 1, smaly);
    spr_at(dl, spr::SPRITE_SLASH, 2, smalx + 1, smaly + 1);
    spr_at(dl, spr::SPRITE_SLASH, 2, smalx, smaly + 1);
    spr_at(dl, spr::SPRITE_SLASH, 0, smalx, smaly);
    // hp max "4": HPmaxx = smalx + 8 + 1
    let hpmaxx = smalx + 8 + 1;
    spr_at(dl, spr::SPRITE_NUMBER, 4 + 20, hpmaxx + 1, smaly);
    spr_at(dl, spr::SPRITE_NUMBER, 4 + 20, hpmaxx + 1, smaly + 1);
    spr_at(dl, spr::SPRITE_NUMBER, 4 + 20, hpmaxx, smaly + 1);
    spr_at(dl, spr::SPRITE_NUMBER, 4, hpmaxx, smaly);
}

// drawSpriteGemNumber(x,y,0): "0" right-aligned at x
fn draw_sprite_gem_number(dl: &mut DrawList, x: i32, y: i32) {
    let smaly = y - 5;
    let smalx = x - 8; // stleng=1
    spr_at(dl, spr::SPRITE_NUMBER, 0 + 10, smalx - 1, smaly);
    spr_at(dl, spr::SPRITE_NUMBER, 0 + 10, smalx, smaly - 1);
    spr_at(dl, spr::SPRITE_NUMBER, 0 + 20, smalx + 1, smaly);
    spr_at(dl, spr::SPRITE_NUMBER, 0 + 20, smalx, smaly + 1);
    spr_at(dl, spr::SPRITE_NUMBER, 0, smalx, smaly);
}

// drawSpriteAmmoNumber(x,y,digit) — single digit (stammo 0..8 in menu)
fn draw_sprite_ammo_number(dl: &mut DrawList, x: i32, y: i32, d: u16) {
    let (nx, ny) = (x, y); // digits=0, numberx = x
    // literal offset list from the GML (black frame +20)
    const OFF: [(i32, i32); 12] = [
        (-1, 0), (0, -1), (1, 0), (0, 1), (-1, 1), (0, 0),
        (1, 1), (0, 2), (0, 0), (1, -1), (2, 0), (1, 1),
    ];
    for (dx, dy) in OFF {
        spr_at(dl, spr::SPRITE_NUMBER, d + 20, nx + dx, ny + dy);
    }
    // red frame +10
    spr_at(dl, spr::SPRITE_NUMBER, d + 10, nx, ny + 1);
    spr_at(dl, spr::SPRITE_NUMBER, d + 10, nx + 1, ny);
    // main
    spr_at(dl, spr::SPRITE_NUMBER, d, nx, ny);
}

// objControlerN HUD state mutated during the draw event (GM semantics)
#[repr(C)]
pub struct HudState {
    pub charge_frame: [f64; 185], // GML array vars are f64
    pub ammo_jiggle: f64,
}

impl HudState {
    pub const fn new() -> HudState {
        // scrDrawHudInitStuff (disp4x3): chargeFrame[i] = 3
        HudState { charge_frame: [3.0; 185], ammo_jiggle: 0.0 }
    }
}

pub fn draw_hud_4x3(dl: &mut DrawList, hs: &mut HudState, meter_jiggle: &mut f64, stammo: i32, p_fired: i32) {
    // hp gauge: hpgx = -64-38 = -102, hpgy = 6
    let (hpgx, hpgy) = (-102, 6);
    let hpg_meter = 80.0; // 80 * hp/hpmax
    spr_at(dl, spr::PC_HUD_HP_GAUGE, 1, hpgx, hpgy);
    sprite_stretched(dl, spr::RED_PIXEL, 0, hpgx + 4, hpgy + 5, hpg_meter, 6.0);
    // heart-piece bar: width 0 -> skipped
    // piece dividers: hpgPieceDiv = 20; i = 20,40,60
    let mut i = 20;
    while i < 80 {
        spr_at(dl, spr::HP_GAUGE_BAR, 2, hpgx + 2 + i, hpgy + 12);
        i += 20;
    }
    spr_at(dl, spr::PC_HUD_HP_GAUGE, 0, hpgx, hpgy);
    draw_sprite_hp(dl, hpgx + 36 + 8, hpgy + 9);

    // currency: currencyDrawx = 160+64+38-10 = 252, y = 18
    sprite_ext(dl, spr::HUD_CURRENCY, 0, 252, 18); // origin (53,9)
    draw_sprite_gem_number(dl, 252 - 8, 18);

    // stammo meter, scrDrawHud4x3 verbatim (ammo=8, conRate=1, cbl=1,
    // barHighlightAmt=0 -> stammoHighlight=0)
    let ammo = 8.0f64;
    let stammo_meter = 184.0 * (stammo as f64 / ammo);
    let meter_divide = 23.0; // 184 * (1/8)
    let meter_scale = 23.0;
    let metery = 21.0 + *meter_jiggle;
    if *meter_jiggle != 0.0 {
        *meter_jiggle -= if *meter_jiggle > 0.0 { 1.0 } else { -1.0 };
    }
    spr_at(dl, spr::NEW_HUD_GAUGE, 0, 0, metery as i32);
    let cmx = 174;
    let charge_metery = 229.0 + *meter_jiggle * 4.0;
    spr_at(dl, spr::STAMMO_GAUGE, 0, cmx, (43.0 + *meter_jiggle) as i32);
    let mut whitebardrawy = charge_metery + 5.0;
    if whitebardrawy > 232.0 {
        whitebardrawy = 232.0;
    }
    if stammo > 0 {
        sprite_stretched(dl, spr::DOT, 0, cmx + 5, whitebardrawy as i32, 10.0, -stammo_meter + 5.0);
    }
    let mut i = 0usize;
    while i < 184 {
        let mut charge_sprite = spr::STAMMO_CHARGE;
        if (i as f64) < stammo_meter {
            if hs.charge_frame[i] <= 3.0 {
                hs.charge_frame[i] += 0.8;
            }
            if i == 0 {
                charge_sprite = spr::STAMMO_DIVIDE;
                if hs.charge_frame[i] == 0.0 {
                    hs.charge_frame[i] = 1.0;
                }
            }
        } else {
            charge_sprite = spr::STAMMO_POP;
            if hs.charge_frame[i] >= 1.0 {
                hs.charge_frame[i] -= 0.8;
            }
        }
        let bardrawy = floor_f64(charge_metery - i as f64);
        if bardrawy < 232 {
            spr_at(dl, charge_sprite, hs.charge_frame[i] as u16, cmx + 4, bardrawy);
        }
        i += 1;
    }
    // ammo < 20 divider pass
    let mut fi = 184.0f64 - meter_scale;
    while fi > 0.0 {
        if fi < stammo_meter {
            spr_at(dl, spr::STAMMO_DIVIDE, 1, cmx + 4, floor_f64(charge_metery - fi));
        }
        fi -= meter_scale;
    }
    // meterDivide pass
    let mut di = 184.0f64;
    while di > 0.0 {
        if di < stammo_meter {
            spr_at(dl, spr::STAMMO_DIVIDE, 0, cmx + 4, floor_f64(charge_metery - di));
            spr_at(dl, spr::STAMMO_DIVIDE, 1, cmx + 4, floor_f64(charge_metery - di + 1.0));
            spr_at(dl, spr::STAMMO_DIVIDE, 1, cmx + 4, floor_f64(charge_metery - di - 1.0));
        } else if di == stammo_meter || di == 1.0 {
            spr_at(dl, spr::STAMMO_DIVIDE, 1, cmx + 4, floor_f64(charge_metery - di + 1.0));
        }
        di -= meter_divide;
    }
    spr_at(dl, spr::STAMMO_GAUGE, 1, cmx, (43.0 + *meter_jiggle) as i32);
    if hs.ammo_jiggle > 0.0 {
        hs.ammo_jiggle -= 1.0;
    }
    if hs.ammo_jiggle < 0.0 {
        hs.ammo_jiggle = 0.0;
    }
    if p_fired != 0 {
        hs.ammo_jiggle = 2.0;
    }
    let charge_textx = 16.0 + hs.ammo_jiggle + 160.0;
    draw_sprite_ammo_number(
        dl,
        (charge_textx + 4.0) as i32,
        (239.0 + hs.ammo_jiggle) as i32,
        stammo.clamp(0, 9) as u16,
    );
    spr_at(dl, spr::NEW_HUD_GAUGE, 1, 0, metery as i32);
}

fn floor_f64(v: f64) -> i32 {
    let t = v as i32;
    if (t as f64) > v {
        t - 1
    } else {
        t
    }
}
