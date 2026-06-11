function scrPlayerShootN()
{
    muzzlex = x;
    muzzley = y + 4;
    shotAngle = 270 + aimAngle;
    global.spinJumping = 0;
    
    if (global.stammo > 0)
    {
        global.achNoShot = 0;
        scrSShake(global.pBulScreenShake, global.pBulScreenShakeDur);
        scrShotSound();
        
        if (ysp > global.pBulRecoil)
            ysp = global.pBulRecoil;
        
        if (global.ending)
            ysp = -2;
        
        scrPlayerEmitBullet(muzzlex, muzzley, shotAngle);
        
        if (global.pugLasersight)
            myBullet.bdirRand = 0;
        
        alarm[2] = abs(global.pBulRof);
        
        if (global.pBulRof < 0)
            nonAuto = 1;
        
        instance_create(x, y, bulletCasing);
        global.pFired = 1;
        global.stammo -= global.pBulConRate;
        
        if (global.ending)
        {
            global.stammo = global.ammo;
            
            if (global.ply < (__view_get(e__VW.YView, 0) - 64))
            {
                if (global.ending != 2)
                {
                    global.ending = 2;
                    global.noControl = 1;
                }
                
                with (objPlayer_n)
                    ysp = -3;
                
                if (global.ending == 2)
                {
                    bulGain = audio_sound_get_gain(global.pBulSound);
                    bulGain *= 0.95;
                    audio_sound_gain(global.pBulSound, bulGain, 0);
                    
                    if (bulGain < 0.02)
                    {
                        global.ending = 3;
                        goalStop = 1;
                        instance_create(0, 0, endingFadeOut);
                    }
                }
            }
        }
        
        if (global.stammo <= 0)
        {
            emitSmoke(global.plx, global.ply + 4, 315, 4);
            emitSmoke(global.plx, global.ply + 4, 225, 4);
            scrRisingText(global.plx, global.ply, emptyText);
            soundPlay(26, 90, 0, 1);
            global.stammo = 0;
            noChargeMsg = 1;
            nonAuto = 1;
        }
        
        if (global.pBulBurst)
        {
            if (global.pBulBurstRate > 0)
            {
                if (burstCount < global.pBulBurstAmount)
                {
                    alarm[3] = global.pBulBurstRate;
                    burstCount += 1;
                }
                else
                {
                    burstCount = 0;
                }
            }
            else if (global.pBulBurstRate == 0)
            {
                for (i = 0; i < global.pBulBurstAmount; i += 1)
                    scrPlayerEmitBullet(muzzlex, muzzley, shotAngle);
            }
        }
    }
    else if (jetFrame)
    {
        if (jetFrame < jetMax)
        {
            if (ysp > 0)
            {
                ysp = 0;
                jetFrame += 10;
            }
        }
        
        alarm[2] = 16;
    }
    else
    {
        emitSmoke(global.plx, global.ply + 4, 315, 4);
        emitSmoke(global.plx, global.ply + 4, 225, 4);
        soundPlay(26, 90, 0, 1);
        noAmmoYsp = 3;
        
        if (ysp > noAmmoYsp)
            ysp = noAmmoYsp;
        
        if (!noChargeMsg)
        {
            scrRisingText(global.plx, global.ply, "EMPTY!");
            noChargeMsg = 1;
        }
        
        alarm[2] = 16;
    }
    
    shotDelay = 1;
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
