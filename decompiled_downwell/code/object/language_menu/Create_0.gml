cursorAt = 0;
hCenter = __view_get(e__VW.XView, 0) + 80;
vMiddle = __view_get(e__VW.YView, 0) + (__view_get(e__VW.HView, 0) / 2);
noTouch = 1;
quickX = hCenter - 32;
surfaceX = hCenter + 32;
cursorX = quickX;
powan = 0;
powanx = 0;
powanMax = 1;
wholePowan = 4;
wholePowan2 = 2;
cursorAt = 0;
hCenter = __view_get(e__VW.XView, 0) + 80;
vMiddle = __view_get(e__VW.YView, 0) + (__view_get(e__VW.HView, 0) / 2);
pauseText = langString("menuLanguage");
pauseMenu[0] = langString("menuBack");
pauseMenu[1] = "ENGLISH";
pauseMenu[2] = "にほんご";
pauseMenu[3] = "FRANÇAIS";
pauseMenu[4] = "DEUTSCH";
pauseMenu[5] = "ITALIANO";
pauseMenu[6] = "ESPAÑOL";
pauseMenu[7] = "TÜRKÇE";
pauseMenu[8] = "PORTUGUÊS";
pauseMenu[9] = "РУССКИЙ";
pauseMenu[10] = "english";
noTouch = 0;
maxMenu = 9;
returningMenu = 41;
returningCursor = 4;

if (global.isTablet)
{
    returningMenu = 42;
    returningCursor = 5;
}

if (global.isAndroid)
{
    returningMenu = 44;
    returningCursor = 5;
}
else if (global.isPC)
{
    returningMenu = 43;
    returningCursor = 4;
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
