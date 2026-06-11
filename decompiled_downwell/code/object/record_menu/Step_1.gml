if (powan < powanMax)
    powan += 0.4;

wholePowan -= sign(wholePowan);
wholePowan2 -= sign(wholePowan2);
powanx -= sign(powanx);

if (global.dRightPressed)
{
    cursorAt += 1;
    powan = 0;
    powanx = 1;
    soundPlayOL(324, 90, 0, 1, "UI");
}

if (global.dLeftPressed)
{
    cursorAt -= 1;
    powan = 0;
    powanx = 1;
    soundPlayOL(324, 90, 0, 1, "UI");
}

if (cursorAt > maxMenu)
    cursorAt = 0;

if (cursorAt < 0)
    cursorAt = maxMenu;

if (global.dUp)
{
    if (cursorAt == leaderboardItem)
    {
        if (!global.isPC)
        {
            if (!achievement_available())
                achievement_login();
            
            if (achievement_available())
            {
                soundPlayOL(321, 90, 0, 1, "UI");
                
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
                
                achievement_post_score("gemsSingleRun", global.recordMaxGemsSingleRun);
                achievement_post_score("longestCombo", global.recordMaxCombo);
                
                if (global.recordFastestGame >= 0)
                {
                    stringGameTimeConvert();
                    achievement_post_score("fastestClearTime", timeDecimalSeconds);
                }
                
                if (global.recordFastestGameHard >= 0)
                {
                    stringGameTimeConvertHard();
                    achievement_post_score("fastestClearTimeHard", timeDecimalSeconds);
                }
                
                achievement_show_leaderboards();
            }
        }
        else if (global.isPC)
        {
            instance_create(0, 0, SteamLeaderboardMenu);
            instance_destroy();
            soundPlayOL(322, 90, 0, 1, "UI");
        }
    }
    else if (cursorAt == trophyItem)
    {
        instance_create(0, 0, TrophyMenu);
        instance_destroy();
        soundPlayOL(322, 90, 0, 1, "UI");
    }
    else if (cursorAt == backItem)
    {
        with (instance_create(0, 0, objPauseMenu))
            cursorAt = 4;
        
        instance_destroy();
        soundPlayOL(322, 90, 0, 1, "UI");
    }
    
    global.padCancel = 0;
}

if (global.padCancel)
{
    with (instance_create(0, 0, objPauseMenu))
        cursorAt = 4;
    
    instance_destroy();
}

if (global.pauseInput || !global.isPaused)
{
    instance_destroy();
    
    if (!global.pTimeStop)
    {
        if (audio_is_paused(global.bgm))
            audio_resume_sound(global.bgm);
    }
}
