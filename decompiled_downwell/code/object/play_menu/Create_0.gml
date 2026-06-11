cursorAt = global.playStyle;
dithy = 80;
smoothx = 0;
whompCreate();
loadingGroup = loadForArea(1);
xapart = 48;
plSpDescend = 0;
ysp = 0;
vdithy = -320;
hardApart = 42;
selected = 0;
yall = -128;
styleMax = 4;
runFrame = 0;
runSpeed = 0.25;
styleInit();
vx = __view_get(e__VW.XView, 0);
vy = __view_get(e__VW.YView, 0) + yall;
tiley = 0;
bordery = 36;
tileMaxy = 36;
hardModeText = langString("menuHardMode");
styleSelectText = langString("menuStyleSelect");
lockedText = langString("menuLocked");

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
