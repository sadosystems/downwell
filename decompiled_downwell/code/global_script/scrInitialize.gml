function scrInitialize()
{
    var GATrackingID = "UA-66091528-2";
    global.initTimes += 1;
    display_set_gui_size(__view_get(e__VW.WPort, 0) / 2, __view_get(e__VW.HPort, 0) / 2);
    device_mouse_dbclick_enable(false);
    application_surface_draw_enable(false);
    global.isTablet = 0;
    global.isMobile = 0;
    global.lowSpec = -1;
    global.isAndroid = 0;
    global.isAndroidTablet = 0;
    global.isPC = 0;
    global.debugMode = 0;
    global.showSplash = 0;
    iosGamepad = -1;
    global.tabletButtonAdjustx = 20;
    global.g_cameraHeight = 284;
    global.g_buttonYAdjustment = 0;
    global.g_hudYAdjustment = 0;
    
    if (os_type == os_ios)
    {
        global.isMobile = 1;
        os_lock_orientation(false);
        
        switch (os_device)
        {
            case 2:
            case 3:
                global.isTablet = 1;
                os_lock_orientation(true);
                break;
            
            case 0:
            case 1:
            case 4:
            case 5:
            case 6:
                os_lock_orientation(true);
                break;
            
            case -1:
                os_lock_orientation(true);
                break;
        }
        
        var displayHeight = display_get_height();
        var displayWidth = display_get_width();
        var aspectRatio = displayHeight / displayWidth;
        
        if (aspectRatio > 2)
        {
            var baseAspect = 1.775;
            var aspectDifference = aspectRatio - baseAspect;
            var extraPixels = (284 * aspectDifference) / baseAspect;
            global.g_hudYAdjustment = 11;
            global.g_buttonYAdjustment = -12;
            global.g_cameraHeight += extraPixels;
            global.g_cameraHeight = floor(global.g_cameraHeight);
        }
        else if (aspectRatio < 1.4)
        {
            global.isTablet = true;
        }
        
        window_set_size(160, global.g_cameraHeight);
    }
    else if (os_type == os_android)
    {
        global.isMobile = 1;
        global.isAndroid = 1;
        
        if (os_device == 2)
        {
            global.isTablet = 1;
            global.isAndroidTablet = 1;
        }
    }
    
    if (!global.isMobile && !global.isTablet)
        global.isPC = 1;
    
    global.disp4x3 = -1;
    
    if (global.isTablet)
        global.disp4x3 = 1;
    
    global.pcDispScale = 1;
    global.windowWidth = 380 * global.pcDispScale;
    global.windowHeight = global.g_cameraHeight * global.pcDispScale;
    global.pcbg[0] = -1;
    global.pcbg[1] = 412;
    global.pcbg[2] = 410;
    global.pcbg[3] = 411;
    global.pcbgNum = 0;
    global.pcbgMax = 3;
    
    if (global.isPC)
    {
        global.disp4x3 = 1;
        global.pcDispScale = 2;
        global.windowWidth = 380 * global.pcDispScale;
        global.windowHeight = global.g_cameraHeight * global.pcDispScale;
        global.fullscreenSet = -1;
        global.steamApi = 0;
        global.pcVsync = -1;
    }
    
    if (global.initTimes == 1)
    {
        global.surfaceFx = surface_create(160, global.g_cameraHeight);
        global.surfaceShade = surface_create(160, global.g_cameraHeight);
        global.surfaceButton = surface_create(160, global.g_cameraHeight);
        global.surfaceDissipate = surface_create(160, global.g_cameraHeight);
        global.surfacePause = surface_create(160, global.g_cameraHeight);
    }
    
    steamAchInit();
    scrControlInit();
    scrGlobalStuff();
    scrPlayerRecord();
    scrLoadSave();
    scrShaderListInit();
    unlockInit();
    
    if (global.globalLanguage == "none")
    {
        switch (os_get_language())
        {
            case "en":
                global.globalLanguage = "english";
                break;
            
            case "ja":
                global.globalLanguage = "japanese";
                break;
            
            case "fr":
                global.globalLanguage = "french";
                break;
            
            case "de":
                global.globalLanguage = "german";
                break;
            
            case "it":
                global.globalLanguage = "italian";
                break;
            
            case "es":
                global.globalLanguage = "spanish";
                break;
            
            case "pt":
                global.globalLanguage = "portuguese";
                break;
            
            case "ru":
                global.globalLanguage = "russian";
                break;
            
            default:
                global.globalLanguage = "english";
                break;
        }
    }
    
    draw_set_font(font0);
    audio_sound_gain(sfxGunM, 0.5, 0);
    
    if (!global.hardUnlocked)
        global.hardMode = -1;
    
    if (global.languageJp == 100)
    {
        if (os_get_language() == "ja")
            global.languageJp = 1;
        else
            global.languageJp = 0;
    }
    
    move = 0;
    scrUpgrades();
    soundInitialize();
    audio_stop_all();
    randomize();
    audio_group_load(1);
    audio_group_load(2);
    
    if (global.initTimes == 1)
        surface_resize(application_surface, 160, global.g_cameraHeight);
    
    audio_channel_num(32);
    gamepad_set_axis_deadzone(0, 0.65);
    gemStreakLowNotif = 0;
    global.bgm = 193;
    global.bgmOn = 0;
    global.firstBoot = 0;
    audio_sound_gain(global.bgm, 1, 0);
    global.levelTile[0] = 76;
    global.levelTile[1] = 51;
    global.levelTile[2] = 74;
    global.levelTile[3] = 72;
    global.levelTile[4] = 70;
    global.levelTile[5] = 55;
    global.wallTile = global.levelTile[0];
    global.areaBgm[1] = 194;
    global.areaBgm[2] = 195;
    global.areaBgm[3] = 196;
    global.areaBgm[4] = 197;
    global.areaBgm[5] = 198;
    global.padUp = 0;
    global.padUpHeld = 0;
    global.padUpRel = 0;
    global.padCancel = 0;
    global.padLeft = 0;
    padLeftPressed = 0;
    global.padRight = 0;
    padRightPressed = 0;
    global.isPaused = 0;
    global.soundPlayed[0] = -1;
    global.soundMax = 0;
    global.builderPoint = 0;
    global.areaName[0] = langString("ugDesc" + string(0));
    scrPlayerGlobalStat();
    scrPlayerLevelCurve();
    scrTouchButtonsCreation();
    bStatInitialize();
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
