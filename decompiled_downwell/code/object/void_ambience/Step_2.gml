if (y < (__view_get(e__VW.YView, 0) - 320) || y > (__view_get(e__VW.YView, 0) + 3000))
{
    if (room == rmMain)
    {
        instance_destroy();
        audio_stop_sound(amb);
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
