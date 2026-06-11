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
        with (instance_create(0, 0, OptionMenuAndroid))
            cursorAt = 2;
        
        instance_destroy();
        soundPlayOL(322, 90, 0, 1, "UI");
    }
    
    if (cursorAt == 1)
    {
        global.touchButtonShow *= -1;
        surfaceClear(global.surfacePause);
        ini_open("save.ini");
        ini_write_real("option", "touchShow", global.touchButtonShow);
        ini_close();
        soundPlayOL(321, 90, 0, 1, "UI");
    }
    
    if (cursorAt == 2)
    {
        with (instance_create(0, 0, ButtonAdjustMenu))
            cursorAt = 2;
        
        instance_destroy();
        soundPlayOL(321, 90, 0, 1, "UI");
    }
    
    if (!global.touchButtonShow)
        pauseMenu[1] = buttonsText + ": " + offText;
    else
        pauseMenu[1] = buttonsText + ": " + onText;
}

if (global.padCancel)
{
    with (instance_create(0, 0, OptionMenuAndroid))
        cursorAt = 2;
    
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
