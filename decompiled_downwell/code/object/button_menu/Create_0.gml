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
pauseText = langString("menuButtons");
pauseMenu[0] = langString("menuBack");
pauseMenu[1] = langString("menuVisible");
pauseMenu[2] = langString("menuAdjust");
buttonsText = langString("menuButtons");
onText = langString("menuOn");
offText = langString("menuOff");

if (!global.touchButtonShow)
    pauseMenu[1] = buttonsText + ": " + offText;
else
    pauseMenu[1] = buttonsText + ": " + onText;

noTouch = 0;
maxMenu = 2;

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
