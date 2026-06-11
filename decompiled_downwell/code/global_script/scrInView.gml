function scrInView(arg0, arg1, arg2)
{
    marginx = arg0;
    marginyTop = arg1;
    marginyBottom = arg2;
    
    if (x > (__view_get(e__VW.XView, 0) + marginx) && x < ((__view_get(e__VW.XView, 0) + __view_get(e__VW.WView, 0)) - marginx))
    {
        if (y > (__view_get(e__VW.YView, 0) + marginyTop) && y < (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + marginyBottom))
            return true;
        else
            return false;
    }
    else
    {
        return false;
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
