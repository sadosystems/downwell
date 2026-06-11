stWidth = string_width(string_hash_to_newline(text));
xxx = x;
overXview = (x + (stWidth / 2)) - (__view_get(e__VW.XView, 0) + __view_get(e__VW.WView, 0));
underXview = x - (stWidth / 2) - __view_get(e__VW.XView, 0);

if (overXview > -10)
    xxx = x - overXview - 10;
else if (underXview < 10)
    xxx = x + -underXview + 10;

draw_set_valign(fa_middle);
draw_set_halign(fa_center);

if (drawing)
{
    scrDrawBorderTextBlack(xxx, y, "+ " + string(notifAmount));
    draw_sprite(sprItemNotif, notifType, xxx, y);
}

draw_set_halign(fa_left);

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
