if (y < (__view_get(e__VW.YView, 0) - 320) || y > (__view_get(e__VW.YView, 0) + 3000))
{
    if (room == rmMain)
    {
        for (i = 0; i <= 1; i += 1)
        {
            if (myBaby[i][1])
            {
                with (myBaby[i][0])
                    instance_destroy();
            }
        }
        
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
