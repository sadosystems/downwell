function script128()
{
    if (global.isPC)
    {
        firstBootAfterUpdate171002 = ini_read_real("option", "fullscreenreset", 1);
        global.disp4x3 = ini_read_real("option", "disp4x3", 1);
        global.pcDispScale = ini_read_real("option", "pcDispScale", 2);
        global.pcbgNum = ini_read_real("option", "pcbgNum", 0);
        global.fullscreenSet = ini_read_real("option", "fullscreenSet", -1);
        
        if (firstBootAfterUpdate171002)
        {
            global.fullscreenSet = -1;
            ini_write_real("option", "fullscreenreset", -1);
            ini_write_real("option", "fullscreenSet", -1);
        }
        
        global.touchButtonShow = 0;
        
        if (!global.disp4x3)
        {
            global.windowWidth = 160 * global.pcDispScale;
            global.windowHeight = 284 * global.pcDispScale;
            window_set_size(global.windowWidth, global.windowHeight);
        }
        else
        {
            global.windowWidth = 380 * global.pcDispScale;
            global.windowHeight = 284 * global.pcDispScale;
            window_set_size(global.windowWidth, global.windowHeight);
        }
        
        if (global.fullscreenSet)
            window_set_fullscreen(1);
    }
}
