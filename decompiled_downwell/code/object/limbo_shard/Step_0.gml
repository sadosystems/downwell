if (TimeStopBound())
{
    if (global.pFired)
    {
        if (y > global.ply)
        {
            if (y < (global.ply + 160))
            {
                if (x > (global.plx - 16))
                {
                    if (x < (global.plx + 16))
                    {
                        if (!noTouch)
                        {
                            xsp = sign(x - global.plx) * random(2);
                            ysp = random_range(2, 5);
                            noTouch = 1;
                            alarm[2] = 5;
                        }
                    }
                }
            }
        }
    }
    
    image_speed = imgSp;
    
    if (place_meeting(xx + xsp, yy, sParentSolid))
    {
        xsp *= -1;
        xsp *= 0.7;
    }
    
    yy -= ascendsp;
    
    if (dissapearing)
        dflash *= -1;
    else
        dflash = -1;
}
else
{
    image_speed = 0;
}

if (abs(xsp) < 0.025)
    xsp = sign(xsp) * 0.025;

xx += xsp;
yy += ysp;
xsp *= 0.97;
ysp *= 0.9;
x = round(xx);
y = round(yy);

if (abs(xsp) < 0.05)
    xsp = 0;

if (abs(ysp) < 0.05)
    ysp = 0;

if (instance_number(limboShard) > shardLimit)
{
    if (checkOutOfViewV(0, 0))
        instance_destroy();
}

if (y < __view_get(e__VW.YView, 0))
    instance_destroy();

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
