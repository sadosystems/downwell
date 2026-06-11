function unlockInit()
{
    global.unlockMax = 0;
    global.playerProgress = 0;
    unlockGoalNum();
    chki = 0;
    
    while (true)
    {
        if (global.totalGems >= tng[chki])
            chki += 1;
        else
            break;
        
        if (chki > 41)
            break;
    }
    
    global.playerProgress = chki;
    
    if (global.playerProgress >= 41)
    {
        global.playerProgress = 41;
        global.unlockMax = 1;
    }
    
    global.styleUnlock = 0;
    unlockProgressCheck();
}
