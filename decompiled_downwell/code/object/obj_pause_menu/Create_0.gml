audio_pause_all();
room_speed = 60;
gr = 0;
unlockGoalNum();

while (tng[gr] <= global.totalGems)
    gr += 1;

localAreaText = langString("area" + string(global.area));
maxedText = langString("menuMaxed");
powan = 0;
powanx = 0;
powanMax = 1;
wholePowan = 4;
wholePowan2 = 2;
cursorAt = 0;
hCenter = __view_get(e__VW.XView, 0) + 80;
vMiddle = __view_get(e__VW.YView, 0) + (__view_get(e__VW.HView, 0) / 2);
atSurface = groundRoom();
pauseText = langString("menuPaused");
pauseMenu[0] = langString("menuResume");
pauseMenu[1] = langString("menuRetry");
pauseMenu[2] = langString("menuStyleSelect");
pauseMenu[3] = langString("menuPalette");
pauseMenu[4] = langString("menuStats");
pauseMenu[5] = langString("menuOption");
pauseMenu[6] = "debug";

if (atSurface)
    pauseMenu[1] = langString("menuQuickStart");

noTouch = 0;

if (os_type == os_windows)
{
    noTouch = 1;
    maxMenu = 1;
    resumeX = hCenter - 32;
    suicideX = hCenter + 32;
    buttonsX = -32;
}
else
{
    noTouch = 0;
    maxMenu = 2;
    resumeX = hCenter - 32;
    suicideX = hCenter;
    buttonsX = hCenter + 32;
}

maxMenu = 5;

if (global.isPC)
{
    pauseMenu[6] = langString("menuQuit");
    maxMenu = 6;
}

cursorX = resumeX;

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
