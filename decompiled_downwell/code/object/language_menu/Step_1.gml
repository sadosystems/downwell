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
        soundPlayOL(322, 90, 0, 1, "UI");
    }
    else
    {
        switch (cursorAt)
        {
            case 1:
                global.globalLanguage = "english";
                break;
            
            case 2:
                global.globalLanguage = "japanese";
                break;
            
            case 3:
                global.globalLanguage = "french";
                break;
            
            case 4:
                global.globalLanguage = "german";
                break;
            
            case 5:
                global.globalLanguage = "italian";
                break;
            
            case 6:
                global.globalLanguage = "spanish";
                break;
            
            case 7:
                global.globalLanguage = "turkish";
                break;
            
            case 8:
                global.globalLanguage = "portuguese";
                break;
            
            case 9:
                global.globalLanguage = "russian";
                break;
            
            default:
                global.globalLanguage = "english";
                break;
        }
        
        ini_open("save.ini");
        ini_write_string("option", "globalLanguage", global.globalLanguage);
        ini_close();
        soundPlayOL(321, 90, 0, 1, "UI");
    }
    
    myReturningMenu = instance_create(0, 0, returningMenu);
    myReturningMenu.cursorAt = returningCursor;
    instance_destroy();
}

if (global.padCancel)
{
    soundPlayOL(322, 90, 0, 1, "UI");
    myReturningMenu = instance_create(0, 0, returningMenu);
    myReturningMenu.cursorAt = returningCursor;
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
