if (global.debugMode)
{
    if (global.isPC)
    {
        global.disp4x3 *= -1;
        
        if (!global.disp4x3)
        {
            window_set_size(__view_get(e__VW.WView, 0) * global.pcDispScale, __view_get(e__VW.HView, 0) * global.pcDispScale);
            window_set_position((display_get_width() / 2) - __view_get(e__VW.WView, 0), (display_get_height() / 2) - __view_get(e__VW.HView, 0));
        }
        else
        {
            window_set_size(380 * global.pcDispScale, global.g_cameraHeight * global.pcDispScale);
            global.windowWidth = 380 * global.pcDispScale;
            global.windowHeight = global.g_cameraHeight * global.pcDispScale;
            window_set_position((display_get_width() / 2) - (global.windowWidth / 2), (display_get_height() / 2) - (global.windowHeight / 2));
        }
    }
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
