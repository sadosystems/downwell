if (powan < powanMax)
    powan += 0.4;

wholePowan -= sign(wholePowan);
wholePowan2 -= sign(wholePowan2);
powanx -= sign(powanx);

if (global.dRightPressed)
{
    with (objControlerN)
    {
        global.shaderType += 1;
        
        if (global.shaderType > global.shaderArUnlocked)
            global.shaderType = 0;
        
        ini_open("save.ini");
        ini_write_real("stats", "shader", global.shaderType);
        ini_close();
    }
    
    powan = 0;
    powanx = 4;
    soundPlayOL(338, 90, 0, 1, "UI");
}

if (global.dRight && !global.dLeft)
{
    buttonHold += 1;
    
    if (buttonHold >= 30)
    {
        with (objControlerN)
        {
            global.shaderType += 1;
            
            if (global.shaderType > global.shaderArUnlocked)
                global.shaderType = 0;
            
            ini_open("save.ini");
            ini_write_real("stats", "shader", global.shaderType);
            ini_close();
        }
        
        powan = 0;
        powanx = 4;
        soundPlayOL(338, 90, 0, 1, "UI");
        buttonHold -= 8;
    }
}

if (global.dLeftPressed)
{
    with (objControlerN)
    {
        global.shaderType -= 1;
        
        if (global.shaderType < 0)
            global.shaderType = global.shaderArUnlocked;
        
        ini_open("save.ini");
        ini_write_real("stats", "shader", global.shaderType);
        ini_close();
    }
    
    powan = 0;
    powanx = -4;
    soundPlayOL(338, 90, 0, 1, "UI");
}

if (!global.dRight && global.dLeft)
{
    buttonHold -= 1;
    
    if (buttonHold <= -30)
    {
        with (objControlerN)
        {
            global.shaderType -= 1;
            
            if (global.shaderType < 0)
                global.shaderType = global.shaderArUnlocked;
            
            ini_open("save.ini");
            ini_write_real("stats", "shader", global.shaderType);
            ini_close();
        }
        
        powan = 0;
        powanx = -4;
        soundPlayOL(338, 90, 0, 1, "UI");
        buttonHold += 8;
    }
}

if ((!global.dLeft && !global.dRight) || (global.dLeft && global.dRight))
    buttonHold = 0;

if (cursorAt > maxMenu)
    cursorAt = 0;

if (cursorAt < 0)
    cursorAt = maxMenu;

if (global.dUp || global.padCancel)
{
    if (cursorAt == 0)
    {
        with (instance_create(0, 0, objPauseMenu))
            cursorAt = 3;
        
        soundPlayOL(318, 90, 0, 1, "UI");
        instance_destroy();
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
