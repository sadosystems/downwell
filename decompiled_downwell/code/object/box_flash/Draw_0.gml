x = __view_get(e__VW.XView, 0) + 80;
y = __view_get(e__VW.YView, 0) + myy;
draw_set_color(c_red);
draw_rectangle(x - xsize, y - ysize, x + xsize, y + ysize, 0);
draw_set_color(c_white);
draw_rectangle(x - xsize, y - (ysize * 0.5), x + xsize, y + (ysize * 0.5), 0);

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
