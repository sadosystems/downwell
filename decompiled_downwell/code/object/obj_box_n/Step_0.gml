if (wallHp <= 0)
{
    soundPlayOL(breakSound, 50, 0, 1, "waterThings");
    scrSmokefx(x, y + 4, 1, 0);
    scrFlashballfx(x, y, 1, 0, 2);
    scrEffectSpawn(x, y + 12, 603, 0.5, 270, -60000);
    
    if (global.pugChainReaction)
    {
        myBullet = instance_create(x, y, bulletDrone);
        myBullet.bDir = 90;
        myBullet.bdmg = 20;
        soundPlay(342, 50, 0, 1);
    }
    
    if (global.pugChainReaction)
    {
        target = instance_place(x, y - 16, objBox_n);
        
        if (target)
        {
            if (global.pugChainReaction)
                target.alarm[0] = 5;
            
            if (autoTile)
                target.checked = 0;
        }
        
        target = instance_place(x + 16, y, objBox_n);
        
        if (target)
        {
            if (global.pugChainReaction)
                target.alarm[0] = 5;
            
            if (autoTile)
                target.checked = 0;
        }
        
        target = instance_place(x, y + 16, objBox_n);
        
        if (target)
        {
            if (global.pugChainReaction)
                target.alarm[0] = 5;
            
            if (autoTile)
                target.checked = 0;
        }
        
        target = instance_place(x - 16, y, objBox_n);
        
        if (target)
        {
            if (global.pugChainReaction)
                target.alarm[0] = 5;
            
            if (autoTile)
                target.checked = 0;
        }
    }
    
    instance_destroy();
    instance_create(x, y - 0, breakablesDebris);
    
    if (!global.lowSpec)
        instance_create(x, y - 0, breakablesDebris);
    
    if (global.area != 4)
    {
        if (haveGem == 1)
            scrCurrencySpawn(3);
        
        if (haveGem == 2)
            scrCurrencySpawn(10);
    }
}

alarmStop(0);
