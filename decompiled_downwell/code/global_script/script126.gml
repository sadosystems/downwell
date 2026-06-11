function script126()
{
    if (scrInView(0, 0, 0) && !global.lowSpec)
    {
        if (surface_exists(global.surfaceFx))
        {
            surface_set_target(global.surfaceFx);
            draw_set_blend_mode(bm_subtract);
            draw_sprite(sprLight, 0, (round(x / 2) * 2) - __view_get(e__VW.XView, 0), (round(y / 2) * 2) - __view_get(e__VW.YView, 0));
            draw_set_blend_mode(bm_normal);
            surface_reset_target();
        }
        
        if (surface_exists(global.surfaceButton))
        {
            surface_set_target(global.surfaceButton);
            draw_set_blend_mode(bm_subtract);
            draw_sprite(sprLight, 0, (round(x / 2) * 2) - __view_get(e__VW.XView, 0), (round(y / 2) * 2) - __view_get(e__VW.YView, 0));
            draw_set_blend_mode(bm_normal);
            surface_reset_target();
        }
    }
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
