if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    ysp += global.grav;
    
    if (ysp >= global.maxgrav)
        ysp = global.maxgrav;
    
    if (yy < global.ply && yy > __view_get(e__VW.YView, 0))
    {
        if (!active)
            active = 1;
    }
    else if (grounded)
    {
        active = 0;
    }
    
    if (place_meeting(xx + xsp, yy, sParentSolid))
    {
        while (!place_meeting(xx + sign(xsp), yy, sParentSolid))
            xx += sign(xsp);
        
        xsp *= -1;
    }
    
    if (place_meeting(xx, yy, parentWater))
        inWater = 1;
    else
        inWater = 0;
    
    scrCheckCollisionWith(56);
    
    if (ycollision != 0)
    {
        ysp = 0;
        
        if (ycollision == 1)
            grounded = 1;
    }
    
    if (place_meeting(xx, yy + 1, sParentSolid))
        grounded = 1;
    else
        grounded = 0;
    
    if (grounded)
    {
        sprite_index = sprTentacleye;
        
        if (abs(xsp) > maxsp)
            xsp = maxsp * sign(xsp);
    }
    else if (ysp > 0)
    {
        image_index = 4;
    }
    else
    {
        image_index = 2;
    }
    
    if (xsp != 0)
        image_xscale = sign(xsp);
    
    xx += xsp;
    
    if (yy < (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + 32))
        yy += ysp;
    
    x = round(xx);
    y = round(yy);
}
else
{
    image_speed = 0;
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
