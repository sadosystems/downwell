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
pauseMenu[2] = langString("menuTimer");
pauseMenu[3] = langString("menuVolume");
pauseMenu[4] = langString("menuDisplay");
pauseMenu[5] = langString("menuLanguage");
bgmText = langString("menuBGM");
buttonsText = langString("menuButtons");
timerText = langString("menuTimer");
volumeText = langString("menuVolume");
onText = langString("menuOn");
offText = langString("menuOff");

if (global.noBgm)
    pauseMenu[1] = bgmText + ": " + offText;
else
    pauseMenu[1] = bgmText + ": " + onText;

if (!global.showTimer)
    pauseMenu[2] = timerText + ": " + offText;
else
    pauseMenu[2] = timerText + ": " + onText;

pauseMenu[3] = volumeText + ": " + string(round(global.masterGain * 10));
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
