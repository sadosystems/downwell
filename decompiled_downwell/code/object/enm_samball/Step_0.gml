if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    ysp += global.grav;
    
    if (ysp >= global.maxgrav)
        ysp = global.maxgrav;
    
    if (yy < global.ply && yy > __view_get(e__VW.YView, 0))
    {
    }
    else if (grounded)
    {
        active = 0;
    }
    
    if (!active && grounded)
    {
    }
    
    if (place_meeting(xx + xsp, yy, sParentSolid))
    {
        while (!place_meeting(xx + sign(xsp), yy, sParentSolid))
            xx += sign(xsp);
        
        xsp *= -1;
    }
    
    if (bouncing == 1)
    {
        ysp = jumpsp;
        bouncing = 0;
    }
    
    if (place_meeting(xx, yy + ysp, sParentSolid))
    {
        if (ysp > 0)
        {
            if (place_meeting(xx, yy + 1, sParentSolid))
            {
                ysp = 0;
                grounded = 1;
            }
            else
            {
                coldis = 0;
                
                for (i = 1; !place_meeting(xx, yy + i, sParentSolid); i += 1)
                    coldis += 1;
                
                ysp = coldis;
            }
        }
    }
    else if (place_meeting(xx, yy + 1, sParentSolid))
    {
        grounded = 1;
    }
    else
    {
        grounded = 0;
    }
    
    if (grounded)
        sprite_index = sprSnake;
    else
        sprite_index = sprSnakeAir;
    
    if (xsp != 0)
        image_xscale = -sign(xsp);
    
    if (hitStun)
        xx += round(xsp / 2);
    else
        xx += xsp;
    
    yy += ysp;
    x = round(xx);
    y = round(yy);
}
else
{
    image_speed = 0;
}

if (hit)
{
    hit = 0;
    image_index = 0;
    hitStun = 1;
    alarm[1] = 5;
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
    scrDeadBody(291, takenImpact, 102);
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
