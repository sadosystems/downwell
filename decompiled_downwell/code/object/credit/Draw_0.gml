credity = __view_get(e__VW.YView, 0) + (global.g_cameraHeight / 2) + (142 + scrolly);
creditx = __view_get(e__VW.XView, 0) + 80;
draw_set_halign(fa_center);
draw_set_valign(fa_top);
scrDrawBorderTextBlack(creditx, credity, actualText);

switch (skipInput)
{
    case 1:
        skipText = "s";
        break;
    
    case 2:
        skipText = "sk";
        break;
    
    case 3:
        skipText = "ski";
        break;
    
    case 4:
        skipText = "skip";
        break;
    
    case 5:
        skipText = "Skip";
        break;
    
    case 6:
        skipText = "SKip";
        break;
    
    case 7:
        skipText = "SKIp";
        break;
    
    case 8:
        skipText = "SKIP";
        break;
    
    default:
        skipText = "";
        break;
}

draw_set_halign(fa_left);

if (showSkipText)
    scrDrawBorderTextBlack(__view_get(e__VW.XView, 0) + 8, (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)) - 8 - 8 - 5, skipText);

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
