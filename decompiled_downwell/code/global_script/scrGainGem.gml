function scrGainGem(arg0)
{
    if (obtainable)
    {
        gemAmount = arg0;
        global.currency += gemAmount;
        
        if (global.currency >= 3000)
        {
            steamAchGet(UnknownEnum.Value_15);
            
            if (global.currency >= 5000)
                steamAchGet(UnknownEnum.Value_22);
        }
        
        global.gameGem += gemAmount;
        global.gemStreak += gemAmount;
        global.gemStreakTimer = global.gemStreakTimerStart;
        
        if (global.pugLessResist)
            global.gemStreakTimer += 180;
        
        with (objControlerN)
            gemStreakAscend = 0;
        
        if (global.pugGemPop)
        {
            scrEffectSpawn(global.plx, global.ply - 8, 120, 0.4, 0, 0);
            myBullet = instance_create(global.plx, global.ply, bulletDrone);
            myBullet.bDir = 90 + random_range(-2, 2);
            
            if (gemAmount >= 10)
            {
                myBullet.sprite_index = sprBulTripleB;
                myBullet.bdmg = 30;
                myBullet.bSpeed = 6;
            }
            else
            {
                myBullet.sprite_index = sprBulTriple;
                myBullet.bdmg = 20;
                myBullet.bSpeed = 6;
            }
            
            soundPlay(341, 70, 0, 1);
        }
        else
        {
            soundPlayOL(167, 60, 0, 1, "UI");
        }
        
        scrFxNol(105, 0.8);
        
        if (global.pugGemPowered)
            scrRechargeGem();
        
        instance_destroy();
    }
}

enum UnknownEnum
{
    Value_15 = 15,
    Value_22 = 22
}
