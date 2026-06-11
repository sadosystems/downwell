if (y < (__view_get(e__VW.YView, 0) - 320) || y > (__view_get(e__VW.YView, 0) + 3000))
{
    if (room == rmMain)
    {
        if (mother != 0)
            mother.myBaby[childNum][1] = 0;
        
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
