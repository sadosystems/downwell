if (surface_exists(global.surfaceFx))
{
    surface_set_target(global.surfaceFx);
    txtx = (__view_get(e__VW.XView, 0) + 80) - round(txtWidth / 2) - __view_get(e__VW.XView, 0);
    txty = (__view_get(e__VW.YView, 0) + 84) - __view_get(e__VW.YView, 0);
    
    if (!txtExit)
    {
        for (i = 1; i <= txtLength; i += 1)
        {
            if (i <= txtShown)
            {
                scrDrawBorderTextBlack(txtx + (8 * (i - 1)), txty + txtAt[i][2], txtAt[i][0]);
                
                if (txtAt[i][2] <= 0)
                    txtAt[i][2] += 1;
            }
        }
    }
    else
    {
        for (i = 1; i <= txtLength; i += 1)
        {
            if (i <= txtExit)
            {
                if (txtAt[i][2] <= 4)
                    txtAt[i][2] += 1;
            }
            
            if (txtAt[i][2] <= 3)
                scrDrawBorderTextBlack(txtx + (8 * (i - 1)), txty + txtAt[i][2], txtAt[i][0]);
        }
    }
    
    surface_reset_target();
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
