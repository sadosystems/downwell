// downwell_rs shared renderer shader. Same semantics as app/src/shader.wgsl,
// with everything the frontends vary made uniform: target size, the pal=2
// clip window, and the four palette slot colours (the DOWNWELL shader's
// hardcoded L/M/D/S — the downwiki embed feeds the wiki's live palette).
// app/ migrates onto this when the capture work is at a good stopping point.

struct Uni {
    size: vec4<f32>,   // xy = target px; zw = pal2 clip x range
    pal_l: vec4<f32>,
    pal_m: vec4<f32>,
    pal_d: vec4<f32>,
    pal_s: vec4<f32>,
};

@group(0) @binding(2) var<uniform> u: Uni;

struct Inst {
    @location(0) rect: vec4<f32>,   // x, y, w, h in target px
    @location(1) uv: vec4<f32>,     // u0, v0, u1, v1 normalized
    @location(2) color: vec4<f32>,  // straight-alpha tint
    @location(3) extra: vec4<f32>,  // x: pal flag, y: rotation (radians)
};

struct VsOut {
    @builtin(position) pos: vec4<f32>,
    @location(0) uv: vec2<f32>,
    @location(1) color: vec4<f32>,
    @location(2) pal: f32,
};

@vertex
fn vs_main(@builtin(vertex_index) vi: u32, inst: Inst) -> VsOut {
    // two triangles: (0,0)(1,0)(0,1) / (0,1)(1,0)(1,1)
    let corner = vec2<f32>(
        select(0.0, 1.0, vi == 1u || vi == 4u || vi == 5u),
        select(0.0, 1.0, vi == 2u || vi == 3u || vi == 5u),
    );
    var px = inst.rect.xy + corner * inst.rect.zw;
    let th = inst.extra.y;
    if (th != 0.0) {
        // GM image_angle: CCW degrees; screen y is down, so visual CCW is
        // (x cos + y sin, -x sin + y cos) about the quad center
        let ctr = inst.rect.xy + 0.5 * inst.rect.zw;
        let d = px - ctr;
        px = ctr + vec2<f32>(d.x * cos(th) + d.y * sin(th), -d.x * sin(th) + d.y * cos(th));
    }
    var out: VsOut;
    out.pos = vec4<f32>(px.x / u.size.x * 2.0 - 1.0, 1.0 - px.y / u.size.y * 2.0, 0.0, 1.0);
    out.uv = mix(inst.uv.xy, inst.uv.zw, corner);
    out.color = inst.color;
    out.pal = inst.extra.x;
    return out;
}

@group(0) @binding(0) var atlas: texture_2d<f32>;
@group(0) @binding(1) var samp: sampler;

@fragment
fn fs_main(in: VsOut) -> @location(0) vec4<f32> {
    var c = textureSample(atlas, samp, in.uv);
    if (in.pal > 1.5) {
        // pal 2: clip to the app-surface window
        if (in.pos.x < u.size.z || in.pos.x >= u.size.w) {
            discard;
        }
    }
    if (in.pal > 0.5) {
        // GM shader 0 (shaderTemplate, DOWNWELL palette). GM's shader reads
        // only the texel; our synthetic rects carry their color in the tint,
        // so multiply first (no-op for real sprite draws: tint is white).
        c = c * in.color;
        // Steps r/b/a (not g), classifies, remaps to the palette slots.
        c.r = step(0.5, c.r);
        c.b = step(0.5, c.b);
        c.a = step(0.5, c.a);
        let white_or_not = step(0.8, c.g);
        let blue_or_not = step(0.8, c.b) - white_or_not;
        let red_or_not = step(0.5, c.r - c.g);
        let black_or_not = step(0.5, 1.0 - c.r - c.g - c.b);
        c = vec4<f32>(mix(c.rgb, u.pal_d.rgb, step(0.5, black_or_not)), c.a);
        c = vec4<f32>(mix(c.rgb, u.pal_m.rgb, step(0.5, red_or_not)), c.a);
        c = vec4<f32>(mix(c.rgb, u.pal_s.rgb, step(0.5, blue_or_not)), c.a);
        c = vec4<f32>(mix(c.rgb, u.pal_l.rgb, step(0.5, white_or_not)), c.a);
        return c;
    }
    return c * in.color;
}
