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
pauseText = langString("menuOption");
pauseMenu[0] = langString("menuBack");
pauseMenu[1] = langString("menuBGM");
pauseMenu[2] = langString("menuButtons");
pauseMenu[3] = langString("menuTimer");
pauseMenu[4] = langString("menuLowSpec");
pauseMenu[5] = langString("menuLanguage");
bgmText = langString("menuBGM");
buttonsText = langString("menuButtons");
timerText = langString("menuTimer");
lowSpecText = langString("menuLowSpec");
onText = langString("menuOn");
offText = langString("menuOff");

if (global.noBgm)
    pauseMenu[1] = bgmText + ": " + offText;
else
    pauseMenu[1] = bgmText + ": " + onText;

if (!global.touchButtonShow)
    pauseMenu[2] = buttonsText + ": " + offText;
else
    pauseMenu[2] = buttonsText + ": " + onText;

if (!global.showTimer)
    pauseMenu[3] = timerText + ": " + offText;
else
    pauseMenu[3] = timerText + ": " + onText;

if (!global.lowSpec)
    pauseMenu[4] = lowSpecText + ": " + offText;
else
    pauseMenu[4] = lowSpecText + ": " + onText;

noTouch = 0;
maxMenu = 5;

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
