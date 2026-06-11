if (TimeStopBound())
{
    if (global.pFired && !dodgeStun)
    {
        if (global.ply < y)
            enmdir = random(359);
        
        dodgeStun = 1;
        alarm[1] = 120;
    }
    
    pldir = point_direction(xx, yy, xstart, ystart);
    maxsp = 1.25;
    dirdif = enmdir - pldir;
    
    if (dirdif > 180)
        dirdif -= 360;
    else if (dirdif < -180)
        dirdif += 360;
    
    if (abs(dirdif) < viewcone)
    {
        if (enmsp < maxsp)
            enmsp += accl;
        else
            enmsp = maxsp;
    }
    else if (enmsp > 0.25)
    {
        enmsp -= dccl;
    }
    else
    {
        enmsp = 0.25;
    }
    
    if (dirdif > rotsp)
        enmdir -= rotsp;
    else if (dirdif < -rotsp)
        enmdir += rotsp;
    else
        enmdir = pldir;
    
    xsp = lengthdir_x(maxsp, enmdir);
    ysp = lengthdir_y(maxsp, enmdir);
    xcollision = 0;
    ycollision = 0;
    
    if (xcollision != 0 || ycollision != 0)
    {
        if (xcollision != 0)
        {
            xsp = 0;
            
            if (xcollision == 1)
            {
                if (enmdir > 180)
                    enmdir -= ((enmdir - 270) * 2);
                else
                    enmdir += ((90 + enmdir) * 2);
            }
            else if (xcollision == -1)
            {
                if (enmdir > 180)
                    enmdir += ((270 - enmdir) * 2);
                else
                    enmdir -= ((enmdir - 90) * 2);
            }
        }
        
        if (ycollision != 0)
        {
            ysp = 0;
            
            if (ycollision == 1)
            {
                if (enmdir > 90 && enmdir <= 270)
                    enmdir -= ((enmdir - 180) * 2);
                else
                    enmdir += ((360 - enmdir) * 2);
            }
            else if (ycollision == -1)
            {
                if (enmdir > 90 && enmdir <= 270)
                    enmdir += ((180 - enmdir) * 2);
                else
                    enmdir -= (enmdir * 2);
            }
        }
    }
    
    if (xsp > 0)
        image_xscale = 1;
    else
        image_xscale = -1;
    
    xx += xsp;
    yy += ysp;
    x = round(xx);
    y = round(yy);
}

if (hit)
{
    hit = 0;
    image_index = 0;
    hitStun = 1;
    enmdir = hitDir;
    enmsp = 3;
    alarm[0] = 5;
}

if (hitStun)
    sprite_index = stunSpr;
else
    sprite_index = normalSpr;

if (ehp <= 0)
    alive = 0;

if (!alive)
{
    scrEnemyDeath();
    scrBloodfx(0, 0);
    scrSmokefx(xx, yy, 1, 0);
    scrFlashballfx(xx, yy, 1, 0, 0);
    scrCurrencySpawn(money);
    scrDeadBody(deadSpr, takenImpact, 102);
    instance_destroy();
}
