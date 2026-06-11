if (!global.pTimeStop)
{
    image_speed = imgSp;
    
    if (x < 160)
    {
        xsp = movesp;
        image_index = 0;
    }
    else if (x > 320)
    {
        xsp = -movesp;
        image_index = 0;
    }
    
    xsp *= 0.975;
    ysp *= 0.989;
    xx += xsp;
    yy += ysp;
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
    {
        xsp = sign(xsp) * movesp * -1;
        ysp = movesp * -image_yscale;
        image_index = 0;
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
    instance_destroy();
}
