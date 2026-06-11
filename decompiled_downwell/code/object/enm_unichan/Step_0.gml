if (!global.pTimeStop)
{
    ysp += global.grav;
    bottomline = __view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0);
    
    if (y > bottomline)
    {
        if (y < (bottomline + 64))
            ysp = 8;
    }
    
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
    
    scrCheckCollisionWith(56);
    
    if (xcollision != 0)
        xsp *= -0.3;
    
    if (ycollision != 0)
    {
        ysp = 0;
        
        if (ycollision == 1)
            grounded = 1;
    }
    
    if (place_meeting(xx, yy + 1, sParentSolid))
    {
        if (ysp > 0)
            grounded = 1;
    }
    else
    {
        grounded = 0;
    }
    
    if (place_meeting(x, y, parentWall))
        yy -= 1;
    
    if (y < (bottomline + 160))
    {
        xx += xsp;
        yy += ysp;
    }
    
    x = round(xx);
    y = round(yy);
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
    scrDeadBody(330, takenImpact, 102);
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
