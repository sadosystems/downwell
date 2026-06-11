if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (global.ply > (yy - 96))
    {
        if (!active)
            active = 1;
    }
    
    if (hit)
    {
        if (!active)
            active = 1;
        
        hitStun = 1;
        alarm[1] += 5;
        image_index = 0;
        soundPlayOL(133, 50, 0, 1, "enemymove");
        imgSp = 0;
        alarm[3] = 30;
        hit = 0;
    }
    
    if (!active)
    {
        sprite_index = sprEnmSkeletonIdle;
        imgSp = 0.2;
    }
    else if (active)
    {
        if (sprite_index == sprEnmSkeletonIdle)
        {
            image_index = 0;
            imgSp = 0.3;
        }
        
        sprite_index = sprEnmSkeletonThrow;
        
        if (image_index < 3)
        {
            if (x > global.plx)
                image_xscale = -1;
            else
                image_xscale = 1;
        }
        
        if (image_index > 4)
        {
            if (!eShotDelay)
            {
                myBone = instance_create(x, y - 10, bulletEnmBone);
                soundPlayOL(134, 50, 0, 1, "enemymove");
                yarc = choose(-3, -3.1, -3.2);
                
                if (sign(global.plx - x) != 0)
                    xarc = image_xscale * choose(1, 0.8, 1.2);
                else
                    xarc = 1;
                
                myBone.ysp = yarc;
                myBone.xsp = xarc;
                
                if (xarc != 0)
                    myBone.imgSp *= -sign(xarc);
                
                eShotDelay = 1;
            }
        }
        
        if (image_index > 6)
        {
            if (imgSp != 0)
            {
                imgSp = 0;
                alarm[2] = 30;
            }
        }
    }
    
    if (xsp != 0)
        image_xscale = sign(xsp);
    
    if (!grounded)
        xx += xsp;
    
    yy += ysp;
    x = round(xx);
    y = round(yy);
}
else
{
    image_speed = 0;
    
    if (alarm[0] > 0)
        alarm[0] += 1;
}

if (ehp <= 0)
    alive = 0;

if (!alive)
{
    scrEnemyDeath();
    scrBloodfx(10, 3);
    scrSmokefx(xx, yy, 5, 1);
    scrFlashballfx(xx, yy, 6, 2, 10);
    scrCurrencySpawn(money);
    soundPlayOL(132, 50, 0, 1, "enemymove");
    scrDeadBody(206, takenImpact, 102);
    
    repeat (2)
        instance_create(x, y - 5, breakablesDebris);
    
    instance_destroy();
}

takenImpact = 0;

if (hitStun)
{
    image_index = 0;
    sprite_index = sprEnmSkeletonHit;
}
