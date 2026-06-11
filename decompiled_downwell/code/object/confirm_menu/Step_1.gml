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
        soundPlayOL(321, 90, 0, 1, "UI");
        
        switch (confirmType)
        {
            case 0:
                global.pauseInput = 1;
                ResetPlayer();
                scrNextLevel(1);
                break;
            
            case 1:
                ResetPlayer();
                room_goto(rmPlayMenu);
                break;
            
            case 2:
                if (global.languageJp)
                {
                    ini_open("save.ini");
                    ini_write_real("stats", "jp", 0);
                    ini_close();
                }
                else
                {
                    ini_open("save.ini");
                    ini_write_real("stats", "jp", 1);
                    ini_close();
                }
                
                ResetPlayer();
                BackToSurface();
                break;
            
            case 3:
                ResetPlayer();
                BackToSurface();
                break;
            
            case 4:
                game_end();
                break;
        }
        
        instance_destroy();
    }
    
    if (cursorAt == 1)
    {
        switch (confirmType)
        {
            case 0:
                with (instance_create(0, 0, objPauseMenu))
                    cursorAt = 1;
                
                break;
            
            case 1:
                with (instance_create(0, 0, objPauseMenu))
                    cursorAt = 2;
                
                break;
            
            case 2:
                if (global.isAndroid)
                {
                    with (instance_create(0, 0, OptionMenuAndroid))
                        cursorAt = 5;
                }
                else if (global.isPC)
                {
                    with (instance_create(0, 0, OptionMenuPC))
                        cursorAt = 4;
                }
                else
                {
                    with (instance_create(0, 0, OptionMenu))
                        cursorAt = 4;
                }
                
                break;
            
            case 4:
                with (instance_create(0, 0, objPauseMenu))
                    cursorAt = 6;
                
                break;
        }
        
        soundPlayOL(322, 90, 0, 1, "UI");
        instance_destroy();
    }
    
    global.padCancel = 0;
}

if (global.padCancel)
{
    switch (confirmType)
    {
        case 0:
            with (instance_create(0, 0, objPauseMenu))
                cursorAt = 1;
            
            break;
        
        case 1:
            with (instance_create(0, 0, objPauseMenu))
                cursorAt = 2;
            
            break;
        
        case 2:
            if (global.isAndroid)
            {
                with (instance_create(0, 0, OptionMenuAndroid))
                    cursorAt = 5;
            }
            else
            {
                with (instance_create(0, 0, OptionMenu))
                    cursorAt = 4;
            }
            
            break;
        
        case 4:
            with (instance_create(0, 0, objPauseMenu))
                cursorAt = 6;
            
            break;
    }
    
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
