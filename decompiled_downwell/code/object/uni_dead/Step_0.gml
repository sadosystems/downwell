if (TimeStopBound())
{
    ysp += ugrav;
    
    if (place_meeting(xx + xsp, y, sParentSolid))
    {
        xsp *= -1;
        xsp *= 0.2;
    }
    
    if (place_meeting(xx, y + ysp, sParentSolid))
    {
        if (ysp <= 0)
            ysp = 0;
        
        if (bouncing)
        {
            if (ysp > 0.2)
            {
                ysp *= -0.5;
                xsp *= 0.4;
                
                if (ysp > -0.5)
                    bouncing = 0;
            }
        }
        
        if (!bouncing)
        {
            if (ysp > 0)
            {
                if (place_meeting(xx, y + 1, sParentSolid))
                {
                    ysp = 0;
                    grounded = 1;
                    xsp *= 0.5;
                    
                    if (abs(xsp) < 0.3)
                        xsp = 0;
                }
                else
                {
                    coldis = 0;
                    i = 1;
                    
                    while (!place_meeting(xx, y + i, sParentSolid))
                    {
                        coldis += 1;
                        i += 1;
                        
                        if (i > 16)
                            break;
                    }
                    
                    ysp = coldis;
                }
            }
        }
    }
    
    if (abs(xsp) < 0.05)
        xsp = sign(xsp) * 0.05;
    
    if (global.area != 3)
    {
        xx += xsp;
        y += ysp;
    }
    else
    {
        xx += (xsp / 4);
        y += (ysp / 4);
    }
    
    if (grounded)
        y = round(y);
    
    x = round(xx);
    chkrange = 4;
}
else
{
    for (i = 0; i <= 2; i += 1)
    {
        if (alarm[i] > 0)
            alarm[i] += 1;
    }
}

if (disappearing)
    dflash *= -1;
else
    dflash = -1;
