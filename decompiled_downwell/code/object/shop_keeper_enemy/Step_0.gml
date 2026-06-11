if (active)
{
    ysp += ugrav;
    
    if (ysp >= global.maxgrav)
        ysp = global.maxgrav;
    
    if (place_meeting(x + xsp, y, sParentSolid))
    {
        while (!place_meeting(x + sign(xsp), y, sParentSolid))
            x += sign(xsp);
        
        if (!attacking)
            xsp *= -1;
        else if (attacking)
            xsp *= -0.8;
    }
    
    if (place_meeting(x, y, parentWater))
    {
        if (!inWater)
        {
            inWater = 1;
            sp = 0;
            
            while (place_meeting(x, y - sp, parentWater))
                sp += 1;
            
            repeat (ysp * 3)
                instance_create(x + choose(-2, -1, 0, 1, 2), y - sp, fxSplash);
            
            audio_play_sound(sndSplash, 0, 0);
        }
    }
    else if (inWater)
    {
        sp = 0;
        
        while (place_meeting(x, y - sp, parentWater))
            sp += 1;
        
        repeat (irandom(5) + 3)
            instance_create(x + choose(-2, -1, 0, 1, 2), y - sp, fxSplash);
        
        audio_play_sound(sndSplash, 0, 0);
        inWater = 0;
    }
    
    if (place_meeting(x + xsp, y + ysp, sParentSolid))
    {
        if (ysp > 0)
        {
            if (place_meeting(x, y + 1, sParentSolid))
            {
                ysp = 0;
            }
            else
            {
                coldis = 0;
                
                for (i = 1; !place_meeting(x + xsp, y + i, sParentSolid); i += 1)
                    coldis += 1;
                
                ysp = coldis;
            }
        }
        else
        {
            ysp = 0;
        }
    }
    
    if (place_meeting(x + xsp, y + ysp, sParentSolid))
        ysp = 0;
    
    if (place_meeting(x, y + 1, sParentSolid))
        grounded = 1;
    else
        grounded = 0;
    
    if (xsp != 0)
    {
        if (!attacking)
            image_xscale = sign(xsp);
    }
    
    if (grounded)
    {
        if (!attacking)
        {
            sprite_index = spRun;
            landed = 1;
        }
        
        if (attacking)
        {
            sprite_index = spAttack;
            
            if (!landed)
            {
                image_index = 2;
                landed = 2;
                impactPx = x + (image_xscale * 24);
                impactPy = y + 10;
                myBullet = instance_create(impactPx, impactPy, enemyBulletAni);
                myBullet.sprite_index = sprFxStaffHit;
                myBullet.image_speed = 0.5;
                myBullet.depth = -500000;
                myBullet.bdmg = 8;
                myBullet.bimpacty = 4;
                myBullet.bimpactx = 4;
                soundPlay(13, 50, 0, 1);
            }
            
            if (image_index >= 9)
            {
                attacking = 0;
                alarm[0] = random_range(timerMin, timerMax);
                xsp = sign(xsp) * nsp;
            }
        }
    }
    else if (!grounded)
    {
        if (attacking)
        {
            if (landed != 2)
            {
                sprite_index = spAttack;
                
                if (ysp <= 0)
                    image_index = 0;
                else if (ysp > 0)
                    image_index = 1;
                
                if (landed == 1)
                    landed = 0;
            }
        }
    }
    
    if (!attacking)
        x += xsp;
    
    if (attacking)
    {
        if (!grounded)
            x += xsp;
    }
    
    if (y > (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + 64))
        ysp = 0;
    
    y += ysp;
    
    if (ehp <= 0)
        alive = 0;
    
    if (!alive)
    {
        scrBloodfx(10, 3);
        scrSmokefx(x, y, 5, 1);
        scrFlashballfx(x, y, 6, 2, 10);
        scrCurrencySpawn(money);
        audio_play_sound(sndPlip, 0, 0);
        instance_destroy();
        scrDeadBody(172, takenImpact, 102);
    }
    
    takenImpact = 0;
}
else if (global.ply > (y - 96))
{
    active = 1;
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
