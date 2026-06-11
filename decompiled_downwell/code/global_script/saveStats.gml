function saveStats()
{
    if (global.gameGem > global.recordMaxGemsSingleRun)
        global.recordMaxGemsSingleRun = global.gameGem;
    
    global.totalGems += global.gameGem;
    checkAreaLevel();
    ini_open("save.ini");
    ini_write_real("stats", "gems", global.totalGems);
    ini_write_real("stats", "recordRunGem", global.recordMaxGemsSingleRun);
    ini_write_real("stats", "recordFurthestReached", global.recordFurthestReached);
    
    if (global.isPC)
    {
    }
    
    if (global.bossDead == 2)
    {
        if (!global.hardMode)
        {
            if (global.recordFastestGame <= 1 || global.recordFastestGame > global.gameTime)
            {
                global.recordFastestGame = global.gameTime;
                ini_open("save.ini");
                ini_write_real("stats", "recordFastestGame", global.recordFastestGame);
                ini_close();
            }
            
            ini_open("save.ini");
            ini_write_real("stats", "hardUnlocked", 1);
            ini_close();
        }
        else
        {
            if (global.recordFastestGameHard <= 1 || global.recordFastestGameHard > global.gameTime)
            {
                global.recordFastestGameHard = global.gameTime;
                ini_open("save.ini");
                ini_write_real("stats", "recordFastestGameHard", global.recordFastestGameHard);
                ini_close();
            }
            
            ini_open("save.ini");
            ini_write_real("stats", "hardUnlocked", 1);
            ini_close();
        }
    }
    
    ini_close();
    
    if (achievement_available())
    {
        switch (os_type)
        {
            case os_ios:
                lbidGem = "gemsSingleRun";
                lbidCombo = "longestCombo";
                lbidTime = "fastestClearTime";
                lbidTimeHard = "fastestClearTimeHard";
                break;
            
            case os_android:
                lbidGem = "CgkIlMvEo7UMEAIQAQ";
                lbidCombo = "CgkIlMvEo7UMEAIQAg";
                lbidTime = "CgkIlMvEo7UMEAIQAw";
                lbidTimeHard = "CgkIlMvEo7UMEAIQBA";
                break;
        }
        
        achievement_post_score(lbidGem, global.recordMaxGemsSingleRun);
        achievement_post_score(lbidCombo, global.recordMaxCombo);
        
        if (global.recordFastestGame >= 0)
        {
            stringGameTimeConvert();
            achievement_post_score(lbidTime, timeDecimalSeconds);
        }
        
        if (global.recordFastestGameHard >= 0)
        {
            stringGameTimeConvertHard();
            achievement_post_score(lbidTimeHard, timeDecimalSeconds);
        }
    }
}
