if (TimeStopBound())
{
    if (enmdir > 360)
        enmdir -= 360;
    
    if (enmdir < 0)
        enmdir += 360;
    
    if (enmdir >= 0 && enmdir < (ang16 * 1))
        image_index = 0;
    else if (enmdir >= (ang16 * 1) && enmdir < (ang16 * 3))
        image_index = 1;
    else if (enmdir >= (ang16 * 3) && enmdir < (ang16 * 5))
        image_index = 2;
    else if (enmdir >= (ang16 * 5) && enmdir < (ang16 * 7))
        image_index = 3;
    else if (enmdir >= (ang16 * 7) && enmdir < (ang16 * 9))
        image_index = 4;
    else if (enmdir >= (ang16 * 9) && enmdir < (ang16 * 11))
        image_index = 5;
    else if (enmdir >= (ang16 * 11) && enmdir < (ang16 * 13))
        image_index = 6;
    else if (enmdir >= (ang16 * 13) && enmdir < (ang16 * 15))
        image_index = 7;
    else if (enmdir >= (ang16 * 15) && enmdir < (ang16 * 16))
        image_index = 0;
    
    pldir = point_direction(xx, yy, xtarget, ytarget);
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
    
    xsp = lengthdir_x(enmsp, enmdir);
    ysp = lengthdir_y(enmsp, enmdir);
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
