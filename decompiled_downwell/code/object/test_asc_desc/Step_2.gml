if (yy < (__view_get(e__VW.YView, 0) - 64))
{
    instance_create(x, y, gasDescendFast);
    instance_destroy();
}

scrOutofview();

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
