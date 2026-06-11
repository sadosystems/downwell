if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (!allSet)
    {
        if (collision_point(xx, yy + 16, parentWall, 0, 0))
        {
            yy += 5;
            latched = 1;
        }
        else if (collision_point(xx + 16, yy, parentWall, 0, 0))
        {
            movedir = 90;
            image_angle = movedir;
            xx += 5;
            latched = 1;
        }
        else if (collision_point(xx - 16, yy, parentWall, 0, 0))
        {
            movedir = 270;
            image_angle = movedir;
            xx -= 5;
            latched = 1;
        }
        else if (collision_point(xx, yy - 16, parentWall, 0, 0))
        {
            movedir = 180;
            image_angle = movedir;
            yy -= 5;
            latched = 1;
        }
        
        allSet = 1;
    }
    
    if (!latched)
    {
        ysp += global.grav;
        bottomline = __view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0);
        
        if (y > bottomline)
        {
            if (y < (bottomline + 64))
                ysp = 8;
            else
                ysp = 0;
        }
        
        movedir = 0;
        xsp = 0;
        scrCheckCollisionWith(57);
        
        if (ycollision == 1)
        {
            ysp = 0;
            latched = 1;
        }
        
        xx += xsp;
        yy += ysp;
    }
    
    x = round(xx);
    y = round(yy);
    image_angle = movedir;
}
else
{
    image_speed = 0;
    alarmStop(1);
}

if (hit)
{
    hit = 0;
    image_index = 0;
    hitStun = 1;
    alarm[1] = 5;
}

if (hitStun)
    sprite_index = damageSpr;
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
    audio_play_sound(sndPlip, 0, 0);
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
