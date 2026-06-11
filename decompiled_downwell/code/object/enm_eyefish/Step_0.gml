if (!global.pTimeStop)
{
    image_speed = imgSp;
    scrCheckCollisionWith(57);
    
    if (xcollision != 0)
        xsp = movesp * -xcollision;
    
    xx += xsp;
    
    if (abs(xsp) < 0.03)
        xsp = sign(xsp) * movesp;
    
    x = round(xx);
    xscaleXsp();
    
    if (hit)
        hit = 0;
}
else
{
    image_speed = 0;
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
