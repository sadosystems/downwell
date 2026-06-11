if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (hit)
    {
        hit = 0;
        image_index = 0;
        hitStun = 1;
        alarm[0] = 5;
    }
    
    if (hitStun)
        sprite_index = stunSpr;
    else
        sprite_index = normalSpr;
    
    if (global.plx > x)
        xsp += accl;
    else
        xsp -= accl;
    
    if (abs(xsp) > maxsp)
        xsp = maxsp * sign(xsp);
    
    if (global.ply > y)
        ysp += accl;
    else
        ysp -= accl;
    
    if (abs(ysp) > maxsp)
        ysp = maxsp * sign(ysp);
    
    xx += xsp;
    yy += ysp;
    roundPosition();
}
else
{
    image_speed = 0;
    alarmStop(0);
}

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
