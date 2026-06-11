function scrPlayerLevel()
{
    if (global.playerLevel < 5)
    {
        if (global.playerExp > global.nextLevel[global.playerLevel])
            global.playerLevel += 1;
    }
    
    if (global.playerExp < global.nextLevel[global.playerLevel - 1])
        global.playerLevel -= 1;
}
