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

if (!global.languageJp)
{
    pauseText = "DISPLAY";
    pauseMenu[0] = "BACK";
    pauseMenu[1] = "BORDER";
    pauseMenu[2] = "SCALE";
    pauseMenu[3] = "FULLSCREEN";
    pauseMenu[4] = "TATE MODE";
    borderTxt = "BORDER     ";
    fullscreenTxtOn = "FULLSCREEN ON";
    fullscreenTxtOff = "FULLSCREEN OFF";
    tateTxtOn = "TATE MODE  ON";
    tateTxtOff = "TATE MODE  OFF";
    scaleTxt = "SCALE     x";
}
else
{
    pauseText = "ディスプレイ";
    pauseMenu[0] = "もどる";
    pauseMenu[1] = "ボーダー";
    pauseMenu[2] = "スケール";
    pauseMenu[3] = "フルスクリーン";
    pauseMenu[4] = "タテがめん";
    borderTxt = "ボーダー       ";
    fullscreenTxtOn = "フルスクリーン    ON";
    fullscreenTxtOff = "フルスクリーン    OFF";
    tateTxtOn = "タテがめん      ON";
    tateTxtOff = "タテがめん      OFF";
    scaleTxt = "スケール       x";
}

pauseText = langString("menuDisplay");
pauseMenu[0] = langString("menuBack");
pauseMenu[1] = langString("menuBorder");
pauseMenu[2] = langString("menuScale");
pauseMenu[3] = langString("menuFullScreen");
pauseMenu[4] = langString("menuTate");
borderText = langString("menuBorder") + ": ";
fullscreenText = langString("menuFullScreen");
tateText = langString("menuTate");
scaleText = langString("menuScale") + " x";
onText = langString("menuOn");
offText = langString("menuOff");
pauseMenu[1] = borderText + string(global.pcbgNum);
pauseMenu[2] = scaleText + string(global.pcDispScale);

if (window_get_fullscreen())
{
    pauseMenu[3] = fullscreenText + ": " + onText;
    pauseMenu[2] = scaleText + "-";
}
else
{
    pauseMenu[3] = fullscreenText + ": " + offText;
}

if (global.disp4x3)
    pauseMenu[4] = tateText + ": " + offText;
else
    pauseMenu[4] = tateText + ": " + onText;

pauseMenu[4] = tateText + ": " + string(global.tateRotation);
noTouch = 0;

if (global.pcVsync)
    pauseMenu[5] = "VSYNC: " + onText;
else
    pauseMenu[5] = "VSYNC: " + offText;

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
