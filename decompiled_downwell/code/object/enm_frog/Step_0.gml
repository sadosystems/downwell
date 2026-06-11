if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (!global.gInWater)
        ysp += ugrav;
    else
        ysp += (ugrav / 2);
    
    if (ysp >= global.maxgrav)
        ysp = global.maxgrav;
    
    if (hit)
    {
        hit = 0;
        prepare = 0;
        soundPlayOL(115, 50, 0, 1, "enemymove");
        image_index = 0;
        ysp = 0;
        xsp *= 0.8;
        hitStun = 1;
        alarm[2] = 5;
        alarm[0] = 0;
        alarm[1] = 60;
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
    
    if (xsp != 0)
        image_xscale = sign(xsp);
    
    if (grounded)
    {
        if (!landed)
        {
            landed = 1;
            alarm[1] = 60;
        }
    }
    else
    {
        landed = 0;
    }
    
    if (position_meeting(x, y, parentWater))
        xsp *= 0.95;
    
    if (scrInView(0, 0, 32))
    {
        if (!grounded)
            xx += xsp;
        
        yy += ysp;
    }
    
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
    scrDeadBody(172, takenImpact, 102);
    soundPlayOL(114, 50, 0, 1, "enemymove");
    instance_destroy();
}

if (hitStun)
{
    sprite_index = sprFrogDamage;
}
else if (grounded)
{
    if (!prepare)
    {
        sprite_index = sprFrogIdle;
        imgSp = 0.2;
    }
    else
    {
        sprite_index = sprFrogPrepare;
    }
}
else
{
    sprite_index = sprFrogAir;
    imgSp = 0;
    
    if (ysp < 0)
        image_index = 0;
    else
        image_index = 1;
}
