if (y < (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + 32))
    y = __view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + 32;

x += xsp;

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
