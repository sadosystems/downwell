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
    
    if (global.tabletButtonAdjustx < 50)
        global.tabletButtonAdjustx += 2;
    
    soundPlayOL(324, 90, 0, 1, "UI");
}

if (global.dLeftPressed)
{
    cursorAt -= 1;
    powan = 0;
    powanx = 1;
    global.tabletButtonAdjustx -= 2;
    soundPlayOL(324, 90, 0, 1, "UI");
}

if (cursorAt > maxMenu)
    cursorAt = 0;

if (cursorAt < 0)
    cursorAt = maxMenu;

if (global.dUp)
{
    ini_open("save.ini");
    ini_write_real("option", "tabletButtonAdjustx", global.tabletButtonAdjustx);
    ini_close();
    
    with (instance_create(0, 0, ButtonMenu))
        cursorAt = 2;
    
    instance_destroy();
    soundPlayOL(322, 90, 0, 1, "UI");
}

if (global.padCancel)
{
    with (instance_create(0, 0, ButtonMenu))
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
