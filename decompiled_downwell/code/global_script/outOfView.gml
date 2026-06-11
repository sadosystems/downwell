function outOfView(arg0, arg1)
{
    if (y < (__view_get(e__VW.YView, 0) - arg0) || y > (__view_get(e__VW.YView, 0) + arg1))
    {
        if (room == rmMain)
            instance_destroy();
    }
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
