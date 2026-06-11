vx = __view_get(e__VW.XView, 0);
vy = __view_get(e__VW.YView, 0);
draw_sprite_tiled(sprDitherFade, fadeFrame, vx, vy);

if (showThanks == 1)
{
    draw_set_halign(fa_center);
    scrDrawBorderTextBlack(vx + 80, vy + 144, "THANK YOU FOR# PLAYING!");
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
