if (!attacking)
{
    if (x > __view_get(e__VW.XView, 0) && x < (__view_get(e__VW.XView, 0) + __view_get(e__VW.WView, 0)))
        sameRoom = 1;
    else
        sameRoom = 0;
    
    if (x > global.plx)
        xsp = -nsp;
    else
        xsp = nsp;
    
    if (grounded)
    {
        if (x > global.plx)
            xsp = -nsp;
        else
            xsp = nsp;
        
        if (!place_meeting(x + xsp, y + (ysp - jumpsp), sParentSolid))
        {
            if (sameRoom)
            {
                attacking = 1;
                ysp = -jumpsp;
                image_index = 2;
            }
            
            image_xscale = sign(xsp);
        }
    }
    
    alarm[0] = random_range(timerMin, timerMax);
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
