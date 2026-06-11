scrOutofview();

if (yy < (__view_get(e__VW.YView, 0) - 16))
{
    yy = __view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + (16 * irandom_range(1, 2));
    xx = 160 + (16 * irandom_range(1, 9));
    
    if (instance_number(gasChaser) > 8)
        instance_destroy();
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
