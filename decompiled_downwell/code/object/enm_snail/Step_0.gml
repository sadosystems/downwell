if (!allSet)
{
    if (place_meeting(xx, yy, parentWall))
        instance_destroy();
    
    if (place_meeting(xx + 8, yy, parentWall))
        image_xscale = 1;
    else if (place_meeting(xx - 8, yy, parentWall))
        image_xscale = -1;
    else
        instance_destroy();
    
    allSet = 1;
}

if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (hit)
    {
        hit = 0;
        soundPlayOL(120, 50, 0, 1, "enemymove");
        image_index = 0;
        hitStun = 1;
        alarm[2] += 5;
        alarm[0] = 0;
        alarm[1] = random_range(50, 80);
    }
    
    scrCheckCollisionWith(57);
    
    if (ycollision != 0 || !collision_point(xx + (image_xscale * 16), yy + (sign(ysp) * 8), parentWall, 0, 0))
        ysp *= -1;
    
    yy += ysp;
    
    if (ysp != 0)
        image_yscale = -sign(ysp);
    
    x = round(xx);
    y = round(yy);
}
else
{
    image_speed = 0;
    
    if (alarm[2] > 0)
        alarm[2] += 1;
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
    scrDeadBody(179, takenImpact, 102);
    soundPlayOL(119, 50, 0, 1, "enemymove");
    instance_destroy();
}

if (hitStun)
    sprite_index = sprEnmSnailHit;
else
    sprite_index = sprEnmSnail;
