function script129()
{
    ini_open("save.ini");
    global.totalGems = ini_read_real("stats", "gems", 0);
    global.playStyle = ini_read_real("stats", "style", 0);
    global.languageJp = ini_read_real("stats", "jp", 100);
    global.shaderType = ini_read_real("stats", "shader", 0);
    global.noBgm = ini_read_real("stats", "nobgm", -1);
    global.hardUnlocked = ini_read_real("stats", "hardUnlocked", -1);
    global.recordFurthestReached = ini_read_real("stats", "recordFurthestReached", 0);
    global.recordMaxGemsSingleRun = ini_read_real("stats", "recordRunGem", 0);
    global.recordMaxCombo = ini_read_real("stats", "recordMaxCombo", 0);
    global.recordFastestGame = ini_read_real("stats", "recordFastestGame", -1);
    global.recordFastestGameHard = ini_read_real("stats", "recordFastestGameHard", -1);
    global.masterGain = 0;
    global.masterGain = ini_read_real("option", "masterGain", 0.6);
    audio_master_gain(global.masterGain);
    global.globalLanguage = ini_read_string("option", "globalLanguage", "none");
    
    if (global.isAndroid)
        global.lowSpec = ini_read_real("option", "lowSpec", 1);
    else
        global.lowSpec = ini_read_real("option", "lowSpec", -1);
    
    if (global.isPC)
        global.lowSpec = -1;
    
    if (global.isAndroid)
    {
        devWidth = display_get_width();
        devHeight = display_get_height();
        devRatio = devHeight / devWidth;
        devRatio *= 10;
        devRatio = floor(devRatio);
        
        switch (devRatio)
        {
            case 17:
                global.tabletButtonAdjustx = 20;
                break;
            
            case 16:
                global.tabletButtonAdjustx = 14;
                break;
            
            case 15:
                global.tabletButtonAdjustx = 8;
                break;
            
            case 14:
                global.tabletButtonAdjustx = 2;
                break;
            
            case 13:
                global.tabletButtonAdjustx = -4;
                break;
            
            default:
                global.tabletButtonAdjustx = 20;
        }
    }
    
    global.tabletButtonAdjustx = ini_read_real("option", "tabletButtonAdjustx", global.tabletButtonAdjustx);
    global.hardMode = ini_read_real("option", "hardMode", -1);
    global.showTimer = ini_read_real("option", "showtimer", -1);
    
    if (os_type == os_windows)
        global.touchButtonShow = ini_read_real("option", "touchShow", -1);
    else
        global.touchButtonShow = ini_read_real("option", "touchShow", 1);
    
    if (global.isPC)
    {
        global.disp4x3 = ini_read_real("option", "disp4x3", 1);
        global.pcDispScale = ini_read_real("option", "pcDispScale", 2);
        global.pcbgNum = ini_read_real("option", "pcbgNum", 0);
        global.fullscreenSet = ini_read_real("option", "fullscreenSet", 1);
        global.tateRotation = ini_read_real("option", "taterotation", 0);
        global.touchButtonShow = 0;
        
        if (global.tateRotation == 0)
        {
            global.disp4x3 = 1;
            global.windowWidth = 380 * global.pcDispScale;
            global.windowHeight = 284 * global.pcDispScale;
        }
        else if (global.tateRotation == 1)
        {
            global.disp4x3 = -1;
            global.windowWidth = 160 * global.pcDispScale;
            global.windowHeight = 284 * global.pcDispScale;
        }
        else if (global.tateRotation == 2 || global.tateRotation == 3)
        {
            global.disp4x3 = -1;
            global.windowWidth = 284 * global.pcDispScale;
            global.windowHeight = 160 * global.pcDispScale;
        }
        
        window_set_size(global.windowWidth, global.windowHeight);
        objControlerN.alarm[8] = 2;
        
        if (global.fullscreenSet)
            window_set_fullscreen(1);
        
        window_set_position((display_get_width() / 2) - (global.windowWidth / 2), (display_get_height() / 2) - (global.windowHeight / 2));
    }
    
    ini_close();
}
