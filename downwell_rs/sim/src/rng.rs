// GameMaker 2022 RNG, reverse-engineered from the Downwell Linux runner
// (verified against a gdb call trace + pixel-level capture validation):
//   core:   WELL512 variant @0x424c20 (16xu32 state + index)
//   init:   state[i] = s = ((s*0x343FD + 0x269EC3) >> 16), 16 times; index = 0
//   random(x)        = 1 draw:  d * 2^-32 * x
//   random_range(a,b)= 1 draw:  min + d * 2^-32 * |b-a|
//   irandom(n)       = 2 draws: ((d2 & 0x7fffffff)<<32 | d1) % (n+1)
//   choose(args..)   = 1 draw:  args[d % argc]
// randomize() under libTAS's frozen clock seeds 0.

#[repr(C)]
pub struct GmRng {
    pub s: [u32; 16],
    pub i: usize,
}

impl GmRng {
    pub const fn zeroed() -> GmRng {
        GmRng { s: [0; 16], i: 0 }
    }

    pub fn seed(&mut self, seed: u32) {
        let mut x = seed;
        for w in self.s.iter_mut() {
            x = x.wrapping_mul(0x343FD).wrapping_add(0x269EC3) >> 16;
            *w = x;
        }
        self.i = 0;
    }

    pub fn well(&mut self) -> u32 {
        let i = self.i;
        let a = self.s[i];
        let c13 = self.s[(i + 13) & 15];
        let esi = c13 ^ a;
        let b = (c13 << 15) ^ (a << 16) ^ esi;
        let c9 = self.s[(i + 9) & 15];
        let edi = (c9 >> 11) ^ c9;
        let newa = b ^ edi;
        self.s[i] = newa;
        let r8 = (newa << 5) & 0xDA44_2D20;
        let ni = (i + 15) & 15;
        self.i = ni;
        let e = self.s[ni];
        let v = (esi << 18) ^ b ^ e ^ newa ^ (edi << 28) ^ r8 ^ (e << 2);
        self.s[ni] = v;
        v
    }

    pub fn irandom(&mut self, n: u64) -> u32 {
        let r1 = self.well() as u64;
        let r2 = (self.well() & 0x7fff_ffff) as u64;
        (((r2 << 32) | r1) % (n + 1)) as u32
    }

    pub fn random(&mut self, x: f64) -> f64 {
        self.well() as f64 * 2.328_306_436_538_696_3e-10 * x
    }

    pub fn random_range(&mut self, a: f64, b: f64) -> f64 {
        let (lo, hi) = if a <= b { (a, b) } else { (b, a) };
        lo + self.well() as f64 * 2.328_306_436_538_696_3e-10 * (hi - lo)
    }

    // choose over argc arguments: returns the chosen index
    pub fn choose_index(&mut self, argc: u32) -> u32 {
        self.well() % argc
    }
}
