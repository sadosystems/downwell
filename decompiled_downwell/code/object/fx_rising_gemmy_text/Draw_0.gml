stWidth = string_width(string_hash_to_newline(text));
xxx = x;
overXview = (x + (stWidth / 2)) - (__view_get(e__VW.XView, 0) + __view_get(e__VW.WView, 0));
underXview = x - (stWidth / 2) - __view_get(e__VW.XView, 0);

if (overXview > -10)
    xxx = x - overXview - 10;
else if (underXview < 10)
    xxx = x + -underXview + 10;

if (surface_exists(global.surfaceFx))
{
    surface_set_target(global.surfaceFx);
    draw_set_halign(fa_center);
    
    if (drawing)
        scrGemmyText(xxx - __view_get(e__VW.XView, 0), y - __view_get(e__VW.YView, 0), text);
    
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
