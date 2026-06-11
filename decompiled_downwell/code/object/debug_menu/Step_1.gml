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
}

if (global.dLeftPressed)
{
    cursorAt -= 1;
    powan = 0;
    powanx = 1;
}

if (cursorAt > maxMenu)
    cursorAt = 0;

if (cursorAt < 0)
    cursorAt = maxMenu;

if (global.dUp)
{
    if (cursorAt == 0)
    {
        with (instance_create(0, 0, objPauseMenu))
            cursorAt = 4;
        
        instance_destroy();
    }
    
    if (cursorAt == 1)
    {
        soundPlay(167, 10, 0, 1);
        gainHp(1);
    }
    
    if (cursorAt == 2)
    {
        soundPlay(167, 10, 0, 1);
        global.hardUnlocked = 1;
        ini_open("save.ini");
        ini_write_real("stats", "hardUnlocked", global.hardUnlocked);
        ini_close();
    }
    
    if (cursorAt == 3)
    {
        global.pauseInput = 1;
        scrNextLevel(global.area + 1);
    }
    
    if (cursorAt == 4)
    {
        global.pauseInput = 1;
        room_goto(rmResult);
        global.isPaused = 0;
    }
    
    if (cursorAt == 5)
    {
        getAmount = 10000;
        global.currency += getAmount;
        global.gameGem += getAmount;
        global.gemStreak += getAmount;
        global.gemStreakTimer = global.gemStreakTimerStart;
        
        with (objControlerN)
            gemStreakAscend = 0;
        
        ini_open("save.ini");
        global.totalGems += getAmount;
        ini_write_real("stats", "gems", global.totalGems);
        ini_close();
        soundPlay(167, 10, 0, 1);
    }
    
    if (cursorAt == 6)
    {
        global.totalGems = 0;
        ini_open("save.ini");
        ini_write_real("stats", "gems", 0);
        ini_write_real("stats", "recordRunGem", 0);
        ini_write_real("stats", "recordMaxCombo", 0);
        ini_write_real("stats", "recordFastestGame", -1);
        ini_write_real("stats", "recordFastestGameHard", -1);
        ini_write_real("stats", "recordFurthestReached", 0);
        ini_write_real("stats", "hardUnlocked", -1);
        ini_write_real("option", "hardMode", -1);
        ini_close();
        soundPlay(167, 10, 0, 1);
        ResetPlayer();
        BackToSurface();
    }
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
