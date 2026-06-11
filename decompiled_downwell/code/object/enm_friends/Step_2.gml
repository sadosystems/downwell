if (y < (__view_get(e__VW.YView, 0) - 320) || y > (__view_get(e__VW.YView, 0) + 3000))
{
    if (room == rmMain)
    {
        instance_destroy();
        
        for (i = 0; i <= 1; i += 1)
        {
            if (broAlive[i])
                brother[i].broAlive[i] = 0;
        }
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
