draw_self();

if (showText)
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    
    if (global.languageJp)
        scrDrawBorderTextJp(__view_get(e__VW.XView, 0) + 10, y - 32, speechText);
    else
        scrDrawBorderTextBlack(__view_get(e__VW.XView, 0) + 10, y - 32, speechText);
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
