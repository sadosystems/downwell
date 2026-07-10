// Native smoke test for the browser frontend: boots with the splash skipped,
// runs the menu intro, and dumps frames as PPM for eyeballing. The rasterizer
// is portable, so this exercises everything except the JS glue.
//
// One test fn on purpose: both modes share the crate's static state, and the
// test harness runs separate #[test]s on separate threads.
use std::io::Write;

fn dump(name: &str) {
    let (w, h) = (web::fb_w() as usize, web::fb_h() as usize);
    let fb = unsafe { std::slice::from_raw_parts(web::fb_ptr(), w * h * 4) };
    let path = std::env::temp_dir().join(name);
    let mut f = std::io::BufWriter::new(std::fs::File::create(&path).unwrap());
    write!(f, "P6\n{} {}\n255\n", w, h).unwrap();
    for px in fb.chunks_exact(4) {
        f.write_all(&px[..3]).unwrap();
    }
    eprintln!("wrote {}", path.display());
}

#[test]
fn both_views_render_without_splash() {
    // cinema (default): movie crop, no HUD/borders
    web::boot(0);
    web::frame(0); // frame 1: must already be in the menu (splash skipped)
    dump("web_cin_f1.ppm");
    for _ in 1..180 {
        web::frame(0);
    }
    dump("web_cin_f180.ppm"); // dissolve done
    for _ in 180..600 {
        web::frame(0);
    }
    dump("web_cin_f600.ppm");
    // walk right: camera moves; stars must stay locked to the scene
    for _ in 0..150 {
        web::frame(4);
    }
    dump("web_cin_walk.ppm");

    // classic: full GM window
    web::boot(1);
    for _ in 0..600 {
        web::frame(0);
    }
    dump("web_classic_f600.ppm");
}
