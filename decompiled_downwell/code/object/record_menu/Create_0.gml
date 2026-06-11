cursorAt = 0;
hCenter = __view_get(e__VW.XView, 0) + 80;
vMiddle = __view_get(e__VW.YView, 0) + (__view_get(e__VW.HView, 0) / 2);
reachedString = stringAreaLevelRecord();
fastestTimeString = stringGameTimeConvert();
fastestTimeStringHard = stringGameTimeConvertHard();
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
txtStats = langString("menuStats");
txtFurthest = langString("statFurthest");
txtGems = langString("statGems");
txtCombo = langString("statCombo");
txtTime = langString("statFastestTime");
var menuItem = 0;
leaderboardItem = -1;
trophyItem = -1;
backItem = -1;
pauseMenu[menuItem] = langString("menuBack");
backItem = menuItem;
noTouch = 0;
maxMenu = menuItem;

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
