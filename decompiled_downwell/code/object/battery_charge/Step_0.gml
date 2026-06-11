if (global.ply > y)
    ysp = 1;
else
    ysp = 0.25;

if (!global.pTimeStop && moving)
{
    yy += ysp;
    
    if (yy < (__view_get(e__VW.YView, 0) - 16))
        yy = __view_get(e__VW.YView, 0) - 16;
    else if (yy > (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + 16))
        yy = __view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + 16;
}

roundPosition();

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
