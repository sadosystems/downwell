function drawFx()
{
    if (!global.death && !global.lowSpec)
    {
        if (scrInView(0, 0, 0))
        {
            if (surface_exists(global.surfaceFx))
            {
                surface_set_target(global.surfaceFx);
                draw_sprite_ext(sprite_index, image_index, x - __view_get(e__VW.XView, 0), y - __view_get(e__VW.YView, 0), image_xscale, image_yscale, image_angle, c_white, image_alpha);
                surface_reset_target();
            }
        }
    }
    else
    {
        draw_self();
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
