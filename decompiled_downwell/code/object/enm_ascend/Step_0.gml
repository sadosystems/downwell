if (hit)
{
    hit = 0;
    image_index = 0;
    hitStun = 1;
    alarm[0] = 5;
}

if (hitStun)
    sprite_index = stunSpr;
else
    sprite_index = normalSpr;

if (y < (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)))
{
    if (y < (global.ply - 64))
    {
        ysp += (ascRate * 2);
        
        if (ysp > 2)
            ysp = 2;
        
        descent = 1;
    }
    else if (!descent)
    {
        ysp -= ascRate;
    }
}

if (x > memPlx)
    xsp -= xasc;
else
    xsp += xasc;

if (!shot)
{
    if (y < (global.ply + 64))
    {
        myBul = instance_create(x, y, enmbul1);
        myBul.ebDir = point_direction(x, y, global.plx, global.ply);
        shot = 1;
    }
}

xx += xsp;
yy += ysp;
x = round(xx);
y = round(yy);

if (ehp <= 0)
    alive = 0;

if (!alive)
{
    scrEnemyDeath();
    scrBloodfx(0, 0);
    scrSmokefx(xx, yy, 1, 0);
    scrFlashballfx(xx, yy, 1, 0, 0);
    scrCurrencySpawn(money);
    scrDeadBody(deadSpr, takenImpact, 102);
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
