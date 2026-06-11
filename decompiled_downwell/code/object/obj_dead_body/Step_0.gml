if (TimeStopBound())
{
    if (ysp < -1)
        ysp += ugravhard;
    else
        ysp += ugrav;
    
    if (place_meeting(xx + xsp, yy, sParentSolid))
    {
        xsp *= -1;
        xsp *= 0.2;
    }
    
    if (place_meeting(xx, yy + ysp, sParentSolid))
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
                if (place_meeting(xx, yy + 1, sParentSolid))
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
                    
                    while (!place_meeting(xx, yy + i, sParentSolid))
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
        yy += ysp;
    }
    else
    {
        xx += (xsp / 4);
        yy += (ysp / 4);
    }
    
    y = round(yy);
    x = round(xx);
    chkrange = 4;
    
    if (global.pugRip)
    {
        if (!active)
            objHp = 1;
        
        if (objHp <= 0)
        {
            if (active)
            {
                instance_create(x, yy, bulletExplosion1);
                
                if (global.pugRip == 2)
                {
                    repeat (4)
                        instance_create(x, yy, bulletExplosion1);
                }
                
                repeat (3)
                    instance_create(x, yy, explosionSmall);
                
                instance_destroy();
            }
        }
    }
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
