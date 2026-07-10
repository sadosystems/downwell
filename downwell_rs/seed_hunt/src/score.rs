// Pixel-scoring mode: relax hard constraints to the 4 highest-confidence tuft
// variants, then rank candidates by compositing the whole grass band (palette
// classes) against the captured band at 4 frames.
// band.bin: 4 frames x 16 rows x 160 cols, classes 1=dark 2=white 3=red
// grass_px.bin: 4 variants x 4 frames x 16x24, 0=transparent 1=dark 2=white 3=red

pub const FRAMES: [u32; 4] = [830, 900, 950, 998];
pub const GRASS_ORDER: [i32; 14] = [
    48, 240, 32, 176, 400, 256, 224, 144, 160, 16, 0, 192, 416, 208,
];

pub struct Tables {
    pub band: Vec<u8>,
    pub grass: Vec<u8>,
}

impl Tables {
    pub fn load(dir: &str) -> Tables {
        Tables {
            band: std::fs::read(format!("{dir}/band.bin")).unwrap(),
            grass: std::fs::read(format!("{dir}/grass_px.bin")).unwrap(),
        }
    }
    fn band_at(&self, fi: usize, y: usize, x: usize) -> u8 {
        self.band[fi * 16 * 160 + y * 160 + x]
    }
    fn grass_at(&self, v: usize, fr: usize, y: usize, x: usize) -> u8 {
        self.grass[((v * 4 + fr) * 16 + y) * 24 + x]
    }

    // returns (matched, total) over grass-opaque pixels, all 4 frames
    pub fn score(&self, tufts: &[(i32, u32, f64, u32, bool); 14], phase: u32) -> (u32, u32) {
        let mut ok = 0u32;
        let mut tot = 0u32;
        let mut canvas = [[0u8; 160]; 16];
        for (fi, f) in FRAMES.iter().enumerate() {
            for row in canvas.iter_mut() {
                *row = [0; 160];
            }
            for &(gx, v, sp, i0, dead) in tufts.iter() {
                if dead {
                    continue;
                }
                let fr = ((i0 as f64 + sp * (f - 731 + phase) as f64) % 4.0) as usize;
                let sx = gx - 12 - 32; // view x = 32
                for y in 0..16 {
                    for x in 0..24 {
                        let px = sx + x as i32;
                        if !(0..160).contains(&px) {
                            continue;
                        }
                        let c = self.grass_at(v as usize, fr, y, x);
                        if c != 0 {
                            canvas[y][px as usize] = c;
                        }
                    }
                }
            }
            for y in 0..16 {
                for x in 0..160 {
                    let c = canvas[y][x];
                    if c != 0 {
                        tot += 1;
                        if self.band_at(fi, y, x) == c {
                            ok += 1;
                        }
                    }
                }
            }
        }
        (ok, tot)
    }
}
