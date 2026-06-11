if (global.debugMode)
{
    global.toggleGuncut *= -1;
    
    if (global.toggleGuncut)
        soundPlayOL(96, 80, 0, 1, "UI");
    else
        soundPlayOL(94, 80, 0, 1, "UI");
}
