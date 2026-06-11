function drawShade()
{
    if (!global.lowSpec)
    {
        if (scrInView(0, 0, 0) && !global.noControl)
        {
            if (surface_exists(global.surfaceShade))
            {
                surface_set_target(global.surfaceShade);
                draw_sprite(sprLight, 0, (round(x / 2) * 2) - __view_get(e__VW.XView, 0), (round(y / 2) * 2) - __view_get(e__VW.YView, 0));
                surface_reset_target();
            }
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
