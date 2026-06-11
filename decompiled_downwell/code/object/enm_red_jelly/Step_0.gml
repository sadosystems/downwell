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
    
    if (image_yscale == 1)
    {
        if (y < (__view_get(e__VW.YView, 0) - 8))
        {
            image_yscale = -1;
            ysp = movesp * -image_yscale;
        }
    }
    
    xsp *= decclRate;
    ysp *= decclRate;
    xx += xsp;
    yy += ysp;
    x = round(xx);
    y = round(yy);
    
    if (hit)
    {
        hit = 0;
        soundPlayOL(147, 50, 0, 1, "waterEnemy");
        xsp *= decclRate;
        ysp *= decclRate;
        hitStun = 1;
        alarm[0] = 5;
    }
    
    if (floor(image_index) == 1)
    {
        boost = 0;
    }
    else if (floor(image_index) == 6)
    {
        if (!boost)
        {
            xsp = sign(xsp) * movesp * -1;
            ysp = movesp * -image_yscale;
            xscaleXsp();
            boost = 1;
        }
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
    soundPlayOL(146, 50, 0, 1, "waterEnemy");
    instance_destroy();
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
