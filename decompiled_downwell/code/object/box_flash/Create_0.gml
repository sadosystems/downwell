x = __view_get(e__VW.XView, 0) + 80;
myy = ystart - __view_get(e__VW.YView, 0);
y = __view_get(e__VW.YView, 0) + myy;
xsize = 90;
ysize = 0;
yssp = 0.01;
phase = 0;
alarm[1] = 3;

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
