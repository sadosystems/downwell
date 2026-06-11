cursorAt = 0;
leaderboardLoaded = 0;
score_get = "";
score_get = steam_download_scores("HIGHEST GEM COUNT IN A RUN", 1, 8);

for (i = 0; i <= 10; i += 1)
{
    steam_name[i] = "-";
    steam_score[i] = 0;
    steam_rank[i] = "-";
}

steamName = steam_get_persona_name();
showingBoard = 0;
boardNum = 7;
boardUpdate = 0;
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
txtFurthest = langString("statFurthest");
txtGems = langString("statGems");
txtCombo = langString("statCombo");
txtTime = langString("statFastestTime");
pauseMenu[0] = langString("menuBack");
noTouch = 0;
maxMenu = 0;

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
