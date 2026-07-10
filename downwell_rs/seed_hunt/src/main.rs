// Verify the WELL512 state (dumped live from the runner under libTAS during
// the splash) against the capture's grass band, searching a small draw offset.
//
// Core RNG: WELL512 variant, transcribed from the runner disassembly @0x424c20.
// irandom(n) = 2 draws: ((r2 & 0x7fffffff)<<32 | r1) % (n+1)   [@0x46d550]
// random(x)  = 1 draw:  r * 2^-32 * x                          [@0x46d3c0]
// choose(..) assumed irandom(argc-1) (2 draws).
mod score;
use score::{Tables, GRASS_ORDER};

// gdb dump at 0xb46fe0 / index 0xb47020, quiescent through the splash
const STATE: [u32; 16] = [
    0x03277882, 0x664cd791, 0x625e3826, 0xa662c15f,
    0xf2e60b48, 0xb99d92fc, 0xbf4bfb7c, 0x69d19cda,
    0x830e5fd9, 0x6ae8ccd1, 0x664788da, 0xf2b911b2,
    0xfecdc18b, 0xb0e04cde, 0x109c918c, 0xb992732d,
];
const INDEX: usize = 3;

struct Rng {
    s: [u32; 16],
    i: usize,
}
impl Rng {
    fn well(&mut self) -> u32 {
        let i = self.i;
        let a = self.s[i];
        let c13 = self.s[(i + 13) & 15];
        let esi = c13 ^ a;
        let ecx1 = (a << 16) ^ esi;
        let b = (c13 << 15) ^ ecx1;
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
    fn irandom(&mut self, n: u64) -> u32 {
        let r1 = self.well() as u64;
        let r2 = (self.well() & 0x7fff_ffff) as u64;
        (((r2 << 32) | r1) % (n + 1)) as u32
    }
    fn random(&mut self, x: f64) -> f64 {
        self.well() as f64 * 2.3283064365386963e-10 * x
    }
    // exact inverse of well(): recovers the previous state
    fn unwell(&mut self) {
        let ni = self.i; // index after the forward step
        let i = (ni + 1) & 15; // index before
        let v = self.s[ni];
        let newa = self.s[i];
        let c13 = self.s[(i + 13) & 15];
        let c9 = self.s[(i + 9) & 15];
        let edi = (c9 >> 11) ^ c9;
        let b = newa ^ edi;
        // b = (c13<<15) ^ (a<<16) ^ c13 ^ a  ->  y = (a<<16) ^ a
        let y = b ^ (c13 << 15) ^ c13;
        let low = y & 0xFFFF;
        let a = ((y >> 16) ^ low) << 16 | low;
        let esi = c13 ^ a;
        let r8 = (newa << 5) & 0xDA44_2D20;
        // v = (esi<<18) ^ b ^ e ^ newa ^ (edi<<28) ^ r8 ^ (e<<2)
        let z = v ^ (esi << 18) ^ b ^ newa ^ (edi << 28) ^ r8;
        // solve e ^ (e<<2) = z
        let mut e = 0u32;
        for bit in 0..32 {
            let prev = if bit >= 2 { (e >> (bit - 2)) & 1 } else { 0 };
            let zb = (z >> bit) & 1;
            e |= (zb ^ prev) << bit;
        }
        self.s[ni] = e;
        self.s[i] = a;
        self.i = i;
    }
}

fn main() {
    let dir = std::env::args().nth(1).expect("usage: seed_hunt <tables dir>");
    let tables = Tables::load(&dir);
    for k in 0..400usize {
        let mut r = Rng { s: STATE, i: INDEX };
        for _ in 0..k {
            r.unwell();
        }
        let pose = r.irandom(5);
        let mut tufts = [(0i32, 0u32, 0f64, 0u32, false); 14];
        for t in 0..14 {
            let v = r.irandom(3);
            let sp = 0.15 + r.random(0.1);
            let i0 = r.irandom(3);
            let dead = r.random(10.0) < 1.0;
            tufts[t] = (GRASS_ORDER[t], v, sp, i0, dead);
            if t == 2 {
                r.irandom(5); // objTree choose
                r.irandom(3); // groundTrees@160
            }
        }
        let t16 = r.irandom(3); // groundTrees@-16
        for phase in [0u32, 1] {
            let (ok, tot) = tables.score(&tufts, phase);
            let sc = ok as f64 / tot.max(1) as f64;
            if sc > 0.8 {
                println!(
                    "k={k} phase={phase} score={sc:.4} pose={pose} trees16={t16} tufts={:?}",
                    &tufts[..4]
                );
            }
        }
    }
}
