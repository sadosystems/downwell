if (allSet)
{
    txtx = x - (txtWidth / 2);
    overXview = (x + (txtWidth / 2)) - (__view_get(e__VW.XView, 0) + __view_get(e__VW.WView, 0));
    underXview = x - (txtWidth / 2) - __view_get(e__VW.XView, 0);
    
    if (overXview > -10)
        txtx = txtx - overXview - 10;
    else if (underXview < 10)
        txtx = txtx + -underXview + 10;
    
    txty = y - 32;
    
    if (!txtExit)
    {
        for (i = 1; i <= txtLength; i += 1)
        {
            if (i <= txtShown)
            {
                switch (txtAt[i][2])
                {
                    case 0:
                        stepy = 5;
                        break;
                    
                    case 1:
                        stepy = 3;
                        break;
                    
                    case 2:
                        stepy = 1;
                        break;
                    
                    case 3:
                        stepy = -1;
                        break;
                    
                    case 4:
                        stepy = -3;
                        break;
                    
                    case 5:
                        stepy = -2;
                        break;
                    
                    case 6:
                        stepy = -1;
                        break;
                    
                    case 7:
                        stepy = 1;
                        break;
                    
                    case 8:
                        stepy = 0;
                        break;
                }
                
                stepy *= 2;
                scrDrawBorderTextBlack(txtx + (8 * (i - 1)), txty + stepy, txtAt[i][0]);
            }
        }
        
        if (!allShown)
        {
            if (txtAt[txtLength][2] >= 8)
            {
                allShown = 1;
                myNotif = instance_create(x, y + 4, itemNotif);
                myNotif.notifType = moduleType;
                myNotif.notifAmount = itemAmount;
                
                switch (moduleType)
                {
                    case 0:
                        soundPlay(105, 100, 0, 1);
                        break;
                    
                    case 1:
                        soundPlay(106, 100, 0, 1);
                        break;
                }
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
