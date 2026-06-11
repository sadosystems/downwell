if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    ysp += ugrav;
    
    if (ysp >= global.maxgrav)
        ysp = global.maxgrav;
    
    if (hit)
    {
        hit = 0;
        image_index = 0;
        hitStun = 1;
        alarm[0] += 3;
    }
    
    if (!active)
    {
        active = 1;
        alarm[1] = 10 + irandom(50);
        leapState = 1;
    }
    
    scrCheckCollisionWith(87);
    
    if (ycollision != 0)
    {
        if (ycollision == 1)
        {
            if (!place_meeting(xx, yy, parentThinwall))
            {
                grounded = 1;
                ysp = 0;
            }
        }
    }
    
    scrCheckCollisionWith(57);
    
    if (xcollision != 0)
        xsp *= -1;
    
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
    
    if (grounded)
    {
        if (leapState == 2)
        {
            alarm[1] = 10 + irandom(50);
            leapState = 1;
        }
    }
    
    if (scrInView(0, 0, 32) && !hitStun)
    {
        if (!grounded)
            xx += xsp;
        
        yy += ysp;
    }
    
    xscaleXsp();
    x = round(xx);
    y = round(yy);
}
else
{
    image_speed = 0;
    
    if (alarm[0] > 0)
        alarm[0] += 1;
    
    if (alarm[1] > 0)
        alarm[1] += 1;
    
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
    audio_play_sound(sndPlip, 0, 0);
    instance_destroy();
}

if (hitStun)
{
    sprite_index = sprJslimeDmg;
}
else if (grounded)
{
    sprite_index = sprSmileSlime;
}
else
{
    sprite_index = sprSmileSlimeAir;
    
    if (abs(ysp) < 1)
        image_index = 1;
    else if (ysp < 0)
        image_index = 0;
    else if (ysp > 0)
        image_index = 1;
}
