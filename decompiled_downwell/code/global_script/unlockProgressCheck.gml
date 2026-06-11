function unlockProgressCheck()
{
    for (i = 1; i <= global.playerProgress; i += 1)
    {
        if (i == 3 || i == 7 || i == 11 || i == 13)
            global.styleUnlock += 1;
        else
            global.shaderArUnlocked += 1;
    }
    
    if (global.shaderArUnlocked >= global.shaderArMax)
        global.shaderArUnlocked = global.shaderArMax;
}
