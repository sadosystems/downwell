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
    if (cursorAt == 0)
    {
        with (instance_create(0, 0, objPauseMenu))
            cursorAt = 5;
        
        instance_destroy();
        soundPlayOL(322, 90, 0, 1, "UI");
    }
    else
    {
        soundPlayOL(321, 90, 0, 1, "UI");
    }
    
    if (cursorAt == 1)
    {
        global.noBgm *= -1;
        
        if (global.noBgm == 1)
        {
            audio_stop_sound(global.bgm);
        }
        else if (global.area != 5)
        {
            audio_play_sound(global.bgm, 100, 1);
            audio_pause_sound(global.bgm);
        }
        else if (global.fightStarted)
        {
            audio_play_sound(global.bgm, 100, 1);
            audio_pause_sound(global.bgm);
        }
        
        ini_open("save.ini");
        ini_write_real("stats", "nobgm", global.noBgm);
        ini_close();
    }
    
    if (cursorAt == 2)
    {
        global.showTimer *= -1;
        ini_open("save.ini");
        ini_write_real("option", "showtimer", global.showTimer);
        ini_close();
    }
    
    if (cursorAt == 3)
    {
        global.masterGain -= 0.1;
        
        if (global.masterGain < 0)
            global.masterGain = 1;
        
        audio_master_gain(global.masterGain);
        ini_open("save.ini");
        ini_write_real("option", "masterGain", global.masterGain);
        ini_close();
        soundPlayOL(321, 90, 0, 1, "UI");
    }
    
    if (cursorAt == 4)
    {
        instance_create(0, 0, DisplayMenu);
        instance_destroy();
    }
    
    if (cursorAt == 5)
    {
        instance_create(0, 0, LanguageMenu);
        instance_destroy();
    }
    
    if (global.noBgm)
        pauseMenu[1] = bgmText + ": " + offText;
    else
        pauseMenu[1] = bgmText + ": " + onText;
    
    if (!global.showTimer)
        pauseMenu[2] = timerText + ": " + offText;
    else
        pauseMenu[2] = timerText + ": " + onText;
    
    pauseMenu[3] = volumeText + ": " + string(round(global.masterGain * 10));
}

if (global.padCancel)
{
    with (instance_create(0, 0, objPauseMenu))
        cursorAt = 5;
    
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
