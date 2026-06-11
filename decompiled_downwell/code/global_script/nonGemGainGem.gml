function nonGemGainGem(arg0)
{
    gemAmount = arg0;
    global.currency += gemAmount;
    global.gameGem += gemAmount;
    global.gemStreak += gemAmount;
    global.gemStreakTimer = global.gemStreakTimerStart;
    
    if (global.pugLessResist)
        global.gemStreakTimer += 180;
    
    with (objControlerN)
        gemStreakAscend = 0;
    
    soundPlay(167, 80, 0, 1);
    scrFxNol(105, 0.8);
}
