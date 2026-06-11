if (TimeStopBound())
{
    image_speed = imgSp;
    ysp = -ascendsp;
    
    if (place_meeting(xx + xsp, yy, parentWall))
    {
        xsp *= -1;
        xsp *= 0.5;
    }
    
    if (!place_meeting(x, y, parentWater))
        instance_destroy();
    
    if (dissapearing)
        dflash *= -1;
    else
        dflash = -1;
}
else
{
    image_speed = 0;
}

if (y < (__view_get(e__VW.YView, 0) - 16))
    instance_destroy();

if (abs(xsp) < 0.01)
    xsp = 0;

xx += xsp;
yy += ysp;
xsp *= 0.975;
ysp *= 0.9;
x = round(xx);
y = round(yy);

if (abs(xsp) < 0.01)
    xsp = 0;

if (abs(ysp) < 0.05)
    ysp = 0;

if (y < __view_get(e__VW.YView, 0))
    instance_destroy();

if (instance_number(airBubbleMicro) > 48)
{
    if (choose(0, 0, 1))
        instance_destroy();
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
