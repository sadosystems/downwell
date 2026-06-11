if (TimeStopBound())
{
    if (global.pFired && !dodgeStun)
    {
        if (global.ply < y)
        {
            if (global.plx > x)
                enmdir = 225;
            else
                enmdir = 315;
            
            enmsp = 2;
        }
        
        dodgeStun = 1;
        alarm[1] = 120;
    }
    
    if (global.ply > (y + 48))
    {
        pldir = 270;
        maxsp = 2;
    }
    else
    {
        pldir = point_direction(xx, yy, global.plx, global.ply - 8);
        maxsp = 1.25;
    }
    
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
    
    xsp = lengthdir_x(enmsp, enmdir);
    ysp = lengthdir_y(enmsp, enmdir);
    scrCheckCollisionWith(57);
    
    if (xcollision != 0)
        xsp = 0;
    
    if (ycollision != 0)
        ysp = 0;
    
    if (abs(xsp) > 0.4)
    {
        if (xsp > 0)
            normalSpr = 300;
        else
            normalSpr = 299;
    }
    else
    {
        normalSpr = 298;
    }
    
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
