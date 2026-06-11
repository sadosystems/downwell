if (!global.pTimeStop)
{
    image_speed = imgSp;
    scrCheckCollisionWith(57);
    
    if (xcollision != 0)
        xsp = movesp * -xcollision;
    
    if (ycollision != 0)
        ysp = 0;
    
    xsp *= 0.95;
    ysp *= 0.9;
    xx += xsp;
    yy += ysp;
    
    if (abs(xsp) < 0.03)
        xsp = sign(xsp) * movesp;
    
    x = round(xx);
    y = round(yy);
    xscaleXsp();
    
    if (hit)
    {
        hit = 0;
        ysp = 1;
        alarm[0] = 5;
    }
    
    if (floor(image_index) == 3)
        xsp = sign(xsp) * movesp;
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
    scrDeadBody(deadSpr, takenImpact, 102);
    soundPlayOL(123, 50, 0, 1, "waterEnemy");
    instance_destroy();
}
