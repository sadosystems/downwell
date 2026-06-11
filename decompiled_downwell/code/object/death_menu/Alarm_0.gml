if (resultShown < rsMax)
{
    resultShown += 1;
    apTimer += 2;
    alarm[0] = apTimer;
    
    if (resultShown == 4)
        alarm[0] = 30;
    
    soundPlayOL(325, 90, 0, 1, "UI");
}
