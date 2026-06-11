function scrControlBeginstepCheck()
{
    if (!global.isPC)
    {
        scrTouchButtonsBegin();
        scrControlInputMobile();
    }
    else
    {
        scrControlInput();
    }
    
    global.soundMax = 0;
    global.soundPlayed[0] = -1;
    channelDuckRegain();
    
    if (global.ending == 2)
    {
        with (objPlayer_n)
        {
            if (!shotDelay)
                scrPlayerShootN();
        }
    }
    
    if (os_is_paused())
    {
        if (global.isAndroid)
        {
            if (!global.isPaused)
                global.pauseInput = 1;
        }
    }
    
    if (global.playerHp > global.playerHpMax)
        global.playerHp = global.playerHpMax;
    
    if (global.ammoConRate != global.pBulConRate)
        global.ammoConRate = global.pBulConRate;
    
    if (!global.pTimeStop && !global.isPaused)
    {
        if (global.gemStreakTimer > 0)
            global.gemStreakTimer -= 1;
        
        if (global.gemStreakTimer <= 0)
        {
            global.gemStreak = 0;
            global.gemStreakTimer = 0;
        }
    }
    
    if (groundRoom())
    {
        if (!audio_is_playing(global.bgm))
        {
            if (audio_group_is_loaded(1))
            {
                soundPlayOL(global.bgm, 100, 1, 1, "music");
                audio_sound_gain(global.bgm, 1, 0);
            }
        }
    }
    
    if (global.gemStreak >= global.gemStreakThreshold)
    {
        if (global.pGunLevel != 1)
        {
            global.gemHigh = 1;
            global.pGunLevel = 1;
            bStatUpdate(global.pGunType, global.pGunLevel);
            soundPlay(158, 90, 0, 1);
            scrEffectSpawn(global.plx, global.ply, 113, 0.5, 0, -50500);
        }
    }
    else if (global.pGunLevel != 0)
    {
        global.gemHigh = 0;
        global.pGunLevel = 0;
        bStatUpdate(global.pGunType, global.pGunLevel);
        
        if (!global.death)
            soundPlay(160, 90, 0, 1);
    }
    
    if (global.gemStreakTimer < 120)
    {
        if (!gemStreakLowNotif)
        {
            if (global.gemStreak >= 100)
            {
            }
            
            gemStreakLowNotif = 1;
        }
    }
    else if (gemStreakLowNotif)
    {
        gemStreakLowNotif = 0;
        
        if (audio_is_playing(sfxGemBoostLow))
            audio_stop_sound(sfxGemBoostLow);
    }
    
    if (global.gemStreakTimer <= 0)
    {
        if (audio_is_playing(sfxGemBoostLow))
            audio_stop_sound(sfxGemBoostLow);
    }
    
    if (global.ug[100][1] > 0)
    {
        gainHp(1);
        global.ug[100][1] -= 1;
        myNotif = instance_create(global.plx, global.ply, itemNotif);
        myNotif.notifType = 1;
        myNotif.notifAmount = 1;
    }
    
    if (global.ug[101][1] > 0)
    {
        global.ammo += 1;
        global.stammo = global.ammo;
        global.ug[101][1] -= 1;
        myNotif = instance_create(global.plx, global.ply, itemNotif);
        myNotif.notifType = 0;
        myNotif.notifAmount = 1;
    }
    
    if (global.ug[102][1] > 0)
    {
        gainHp(2);
        global.ug[102][1] -= 1;
        myNotif = instance_create(global.plx, global.ply, itemNotif);
        myNotif.notifType = 1;
        myNotif.notifAmount = 2;
    }
    
    if (global.ug[103][1] > 0)
    {
        global.ammo += 2;
        global.stammo = global.ammo;
        global.ug[103][1] -= 1;
        myNotif = instance_create(global.plx, global.ply, itemNotif);
        myNotif.notifType = 0;
        myNotif.notifAmount = 2;
    }
    
    if (global.ug[104][1] > 0)
    {
        gainHp(1);
        global.ammo += 1;
        global.stammo = global.ammo;
        global.ug[104][1] -= 1;
        myNotif = instance_create(global.plx, global.ply, itemNotif);
        myNotif.notifType = 2;
        myNotif.notifAmount = 1;
    }
    
    if (global.ug[105][1] > 0)
    {
        global.playerHpMax += 1;
        gainHp(1);
        global.ug[105][1] -= 1;
        myNotif = instance_create(global.plx, global.ply, itemNotif);
        myNotif.notifType = 1;
        myNotif.notifAmount = 1;
    }
    
    if (global.pugKnifefork)
    {
        if (global.bodiesEaten >= 10)
        {
            gainHp(1);
            global.bodiesEaten -= 10;
            scrRisingText(global.plx, global.ply, langString("omnomText"));
            scrFxNol(108, 0.8);
        }
    }
}
