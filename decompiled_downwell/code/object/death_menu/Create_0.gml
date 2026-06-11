cursorAt = 0;
global.deathMenuShow = 1;
soundPlayOL(319, 90, 0, 1, "UI");
inputDisable = 0;
popped = 0;
filling = 0;
powanDesc = 0;
powanText = 0;
styleUnlockSpriteFrame = 0;
progBarShow = 0;
fakeTotalGems = global.totalGems - global.gameGem;

if (fakeTotalGems < 0)
    fakeTotalGems = 0;

fakeTotalSep = fakeTotalGems;
goalPassed = 0;
goalNotif = 0;
gr = 0;
unlockGoalNum();

while (tng[gr] <= fakeTotalGems)
    gr += 1;

hCenter = __view_get(e__VW.XView, 0) + 80;
vMiddle = __view_get(e__VW.YView, 0) + (__view_get(e__VW.HView, 0) / 2);
maxMenu = 1;
resultShown = -1;
apTimer = 8;
alarm[0] = 45;
sequenceOver = 0;
popFrame = 0;
rsMax = 6;

for (i = 0; i <= rsMax; i += 1)
{
    rs[i][0] = 0;
    rs[i][1] = 4;
}

noTouch = 1;
maxMenu = 1;
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
pauseText = langString("menuGameOver");
pauseMenu[0] = langString("menuRetry");
pauseMenu[1] = langString("menuStyleSelect");
pauseMenu[2] = langString("menuSurface");
maxedText = langString("menuMaxed");
styleUnlockText = langString("menuStyleUnlock");
paletteUnlockText = langString("menuPaletteUnlock");
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

maxMenu = 2;
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
