if (surface_exists(global.surfaceFx))
{
    surface_set_target(global.surfaceFx);
    draw_set_halign(fa_center);
    
    if (dFlash)
        scrDrawTextOutlineRed(round(x - __view_get(e__VW.XView, 0)), round(y - __view_get(e__VW.YView, 0)), string(breakText));
    
    draw_set_halign(fa_left);
    surface_reset_target();
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
