x = floor(xx + (__view_get(e__VW.XView, 0) / 1.2));
y = floor((__view_get(e__VW.YView, 0) + (global.g_cameraHeight / 2)) / 1.1);

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
