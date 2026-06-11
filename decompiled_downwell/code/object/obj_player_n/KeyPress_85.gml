if (global.debugMode)
{
    global.oxygen += 100;
    global.ammo += 2;
    global.stammo = global.ammo;
    getAmount = 10000;
    global.currency += getAmount;
    global.gameGem += getAmount;
    global.gemStreak += getAmount;
    global.gemStreakTimer = global.gemStreakTimerStart;
    
    with (objControlerN)
        gemStreakAscend = 0;
    
    soundPlay(167, 10, 0, 1);
    gainHp(2);
    scrFxNol(105, 0.8);
}
