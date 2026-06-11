if (!global.pTimeStop)
{
    image_speed = imgSp;
    
    if (floor(image_index) == 0)
    {
        if (!boost)
        {
            direction = point_direction(x, y, global.eplx, global.eply);
            movesp = 2;
            boost = 1;
        }
    }
    else
    {
        boost = 0;
    }
    
    xsp = lengthdir_x(movesp, direction);
    ysp = lengthdir_y(movesp, direction);
    xscaleXsp();
    
    if (movesp > 0)
        movesp *= 0.965;
    
    if (abs(movesp) < 0.05)
        movesp = 0;
    
    xx += xsp;
    yy += ysp;
    xsp *= decclRate;
    ysp *= decclRate;
    x = round(xx);
    y = round(yy);
    
    if (hit)
    {
        hit = 0;
        soundPlayOL(358, 50, 0, 1, "waterEnemy");
        movesp = 0;
        hitStun = 1;
        alarm[0] = 5;
    }
}
else
{
    image_speed = 0;
    alarmStop(0);
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
    soundPlayOL(357, 50, 0, 1, "waterEnemy");
    instance_destroy();
}
