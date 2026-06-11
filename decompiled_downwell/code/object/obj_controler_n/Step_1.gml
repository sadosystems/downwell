scrControlBeginstepCheck();

if (gamepad_button_check_pressed(0, gp_start) || gamepad_button_check_pressed(1, gp_start))
    global.pauseInput = 1;

if (os_is_paused())
{
    if (os_device == 3 || os_device == 4)
    {
        if (!global.isPaused)
            global.pauseInput = 1;
    }
}

if (global.pauseInput && !global.noControl)
{
    if (room == rmMain || groundRoom())
    {
        if (!global.isPaused && !global.death)
        {
            if (!surface_exists(global.surfacePause))
                global.surfacePause = surface_create(160, global.g_cameraHeight);
            
            surface_copy(global.surfacePause, 0, 0, application_surface);
            instance_deactivate_all(1);
            pauseMenu = instance_create(0, 0, objPauseMenu);
            soundPlayOL(326, 90, 0, 1, "UI");
            global.isPaused = 1;
            globalLanguageEnteringPause = global.globalLanguage;
        }
        else
        {
            instance_activate_all();
            global.isPaused = 0;
            afterPause = 1;
            
            if (globalLanguageEnteringPause != global.globalLanguage)
            {
                with (objPlayer_n)
                    emptyText = langString("gunEmpty");
                
                with (Shop)
                    scrShopAssignText();
            }
        }
    }
    
    global.pauseInput = 0;
}

global.pauseInput = 0;

if (afterPause)
{
    global.dUpHeld = 0;
    
    if (global.dUpRel)
        afterPause = 0;
}

if (global.isPaused)
{
    for (i = 0; i <= 7; i += 1)
    {
        if (alarm[i] > 0)
            alarm[i] += 1;
    }
}
