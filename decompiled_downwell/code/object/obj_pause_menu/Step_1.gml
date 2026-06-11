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

if (global.debugMode)
{
    if (global.dLeft && global.dRight)
    {
        instance_create(0, 0, DebugMenu);
        instance_destroy();
    }
}

if (cursorAt > maxMenu)
    cursorAt = 0;

if (cursorAt < 0)
    cursorAt = maxMenu;

if (global.dUp)
{
    if (cursorAt == 0)
    {
        global.pauseInput = 1;
        soundPlayOL(322, 90, 0, 1, "UI");
    }
    else
    {
        soundPlayOL(321, 90, 0, 1, "UI");
    }
    
    if (cursorAt == 1)
    {
        if (atSurface)
        {
            global.pauseInput = 1;
            ResetPlayer();
            scrNextLevel(1);
        }
        else
        {
            with (instance_create(0, 0, ConfirmMenu))
                confirmType = 0;
            
            instance_destroy();
        }
    }
    
    if (cursorAt == 2)
    {
        if (atSurface)
        {
            ResetPlayer();
            room_goto(rmPlayMenu);
        }
        else
        {
            with (instance_create(0, 0, ConfirmMenu))
                confirmType = 1;
            
            instance_destroy();
        }
    }
    
    if (cursorAt == 3)
    {
        instance_create(0, 0, ShaderMenu);
        instance_destroy();
    }
    
    if (cursorAt == 4)
    {
        instance_create(0, 0, RecordMenu);
        instance_destroy();
    }
    
    if (cursorAt == 5)
    {
        if (global.isAndroid)
            instance_create(0, 0, OptionMenuAndroid);
        else if (global.isPC)
            instance_create(0, 0, OptionMenuPC);
        else if (global.isTablet)
            instance_create(0, 0, OptionMenuIpad);
        else
            instance_create(0, 0, OptionMenu);
        
        instance_destroy();
    }
    
    if (cursorAt == 6)
    {
        with (instance_create(0, 0, ConfirmMenu))
        {
            confirmType = 4;
            pauseText = langString("menuConfirmQuit");
            pauseMenu[0] = langString("menuYes");
            pauseMenu[1] = langString("menuNo");
        }
        
        instance_destroy();
    }
    
    global.padCancel = 0;
}
else
{
}

if (global.padCancel)
    global.pauseInput = 1;

if (global.pauseInput || !global.isPaused)
{
    instance_destroy();
    audio_resume_all();
    
    if (global.pTimeStop)
    {
        if (audio_is_playing(global.bgm))
            audio_pause_sound(global.bgm);
    }
}
