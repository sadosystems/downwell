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
        with (instance_create(0, 0, OptionMenuPC))
            cursorAt = 4;
        
        instance_destroy();
        soundPlayOL(322, 90, 0, 1, "UI");
    }
    else
    {
        soundPlayOL(321, 90, 0, 1, "UI");
    }
    
    if (cursorAt == 1)
    {
        global.pcbgNum += 1;
        
        if (global.pcbgNum > global.pcbgMax)
            global.pcbgNum = 0;
        
        pauseMenu[1] = borderText + string(global.pcbgNum);
        ini_open("save.ini");
        ini_write_real("option", "pcbgNum", global.pcbgNum);
        ini_close();
    }
    
    if (cursorAt == 2)
    {
        if (!window_get_fullscreen())
        {
            global.pcDispScale += 0.5;
            
            if (global.disp4x3)
            {
                global.windowWidth = 380;
                global.windowHeight = 284;
            }
            else if (global.tateRotation == 1)
            {
                global.windowWidth = 160;
                global.windowHeight = 284;
            }
            else
            {
                global.windowWidth = 284;
                global.windowHeight = 160;
            }
            
            var _windowWidth = global.windowWidth * global.pcDispScale;
            var _windowHeight = global.windowHeight * global.pcDispScale;
            
            if (_windowWidth > display_get_width() || _windowHeight > display_get_height())
                global.pcDispScale = 1;
            
            global.windowWidth *= global.pcDispScale;
            global.windowHeight *= global.pcDispScale;
            window_set_size(global.windowWidth, global.windowHeight);
            window_set_position((display_get_width() / 2) - (global.windowWidth / 2), (display_get_height() / 2) - (global.windowHeight / 2));
            pauseMenu[2] = scaleText + string(global.pcDispScale);
        }
        
        ini_open("save.ini");
        ini_write_real("option", "pcDispScale", global.pcDispScale);
        ini_close();
    }
    
    if (cursorAt == 3)
    {
        window_set_fullscreen(!window_get_fullscreen());
        window_set_position((display_get_width() / 2) - ((160 * global.pcDispScale) / 2), (display_get_height() / 2) - ((284 * global.pcDispScale) / 2));
        
        if (window_get_fullscreen())
        {
            pauseMenu[3] = fullscreenText + ": " + onText;
            pauseMenu[2] = scaleText + "-";
        }
        else
        {
            pauseMenu[3] = fullscreenText + ": " + offText;
            pauseMenu[2] = scaleText + string(global.pcDispScale);
        }
        
        ini_open("save.ini");
        ini_write_real("option", "fullscreenSet", window_get_fullscreen());
        ini_close();
    }
    
    if (cursorAt == 4)
    {
        global.tateRotation += 1;
        
        if (global.tateRotation > 3)
            global.tateRotation = 0;
        
        if (global.tateRotation == 0)
        {
            global.disp4x3 = 1;
            global.windowWidth = 380 * global.pcDispScale;
            global.windowHeight = 284 * global.pcDispScale;
        }
        else if (global.tateRotation == 1)
        {
            global.disp4x3 = false;
            global.windowWidth = 160 * global.pcDispScale;
            global.windowHeight = 284 * global.pcDispScale;
        }
        else if (global.tateRotation == 2 || global.tateRotation == 3)
        {
            global.disp4x3 = -1;
            global.windowWidth = 284 * global.pcDispScale;
            global.windowHeight = 160 * global.pcDispScale;
        }
        
        pauseMenu[4] = tateText + ": " + string(global.tateRotation);
        window_set_size(global.windowWidth, global.windowHeight);
        window_set_position((display_get_width() / 2) - ((160 * global.pcDispScale) / 2), (display_get_height() / 2) - ((284 * global.pcDispScale) / 2));
        objControlerN.alarm[8] = 2;
        ini_open("save.ini");
        ini_write_real("option", "taterotation", global.tateRotation);
        ini_close();
    }
    
    if (cursorAt == 5)
    {
        global.pcVsync = -global.pcVsync;
        ini_open("save.ini");
        ini_write_real("option", "vsync", global.pcVsync);
        ini_close();
        display_reset(0, global.pcVsync);
        
        if (global.pcVsync)
            pauseMenu[5] = "VSYNC: " + onText;
        else
            pauseMenu[5] = "VSYNC: " + offText;
        
        window_set_size(global.windowWidth, global.windowHeight);
    }
}

if (global.padCancel)
{
    with (instance_create(0, 0, OptionMenuPC))
        cursorAt = 4;
    
    instance_destroy();
    soundPlayOL(322, 90, 0, 1, "UI");
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
