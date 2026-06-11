if (!allSet)
{
    bDir += random_range(-bdirRand, bdirRand);
    allSet = 1;
}

d2wx = 0;
d2wy = 0;
addAmt = 8;
xadd = lengthdir_x(addAmt, bDir);
yadd = lengthdir_y(addAmt, bDir);

while (true)
{
    if (collision_rectangle(x - 8, y, x + 8 + d2wx + xadd, y + d2wy + yadd, subparentEnemy, 0, 0) || collision_line(x, y, x + d2wx + xadd, y + d2wy + yadd, subparentSolidWall, 0, 0) || collision_line(x, y, x + d2wx + xadd, y + d2wy + yadd, parentShootableThing, 0, 0))
    {
        xadd /= 2;
        yadd /= 2;
        
        if (abs(xadd) < 1)
            xadd = sign(xadd) * 1;
        
        if (abs(yadd) < 1)
            yadd = sign(yadd) * 1;
    }
    
    d2wx += xadd;
    d2wy += yadd;
    
    if (!bWave)
    {
        if (place_meeting(x + d2wx, y + d2wy, subparentEnemy))
        {
            break;
        }
        else if (position_meeting(x + d2wx, y + d2wy, subparentSolidWall))
        {
            break;
        }
        else if (place_meeting(x + d2wx, y + d2wy, parentShootableThing))
        {
            if (instance_place(x + d2wx, y + d2wy, parentShootableThing).objHp > 0)
                break;
        }
    }
    else if (bWave)
    {
        if (place_meeting(x + d2wx, y + d2wy, subparentEnemy))
            break;
        else if (position_meeting(x + d2wx, y + d2wy, subparentShootableWall))
            break;
        else if (place_meeting(x + d2wx, y + d2wy, parentShootableThing))
            break;
    }
    
    if ((y + d2wy) > (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)) || (y + d2wy) < __view_get(e__VW.YView, 0))
        break;
    else if ((x + d2wx) < 0 || (x + d2wx) > room_width)
        break;
}

if (!wallMet)
{
    if (abs(d2wy) < 120)
        trailIndex = round(abs(d2wy) / 20) + 2;
    else
        trailIndex = 8;
}
else
{
    trailIndex = 4;
}

t = 0;

while (abs(t) < abs(d2wy))
{
    trailxAdd = lengthdir_x(8, bDir);
    t += (8 * sign(d2wy));
}

trailyAdd = lengthdir_y(8, bDir);
trx = 0;
tr_y = 0;

while (true)
{
    myTrail = instance_create(x + trx, y + tr_y, fxLaserTrail);
    myTrail.sprite_index = sprite_index;
    myTrail.image_index = trailIndex;
    myTrail.image_angle = bDir + 90;
    
    if (!wallMet)
    {
        if (trailIndex > 0)
            trailIndex -= trailRate;
    }
    
    trx += trailxAdd;
    tr_y += trailyAdd;
    
    if (abs(tr_y) > abs(d2wy))
        break;
    else if (abs(trx) > abs(d2wx))
        break;
}

wallMet = 1;
x += d2wx;
y += d2wy;

if (position_meeting(x, y, parentWall) && !collision_line(x, y, x + xsp, y + ysp, subparentEnemy, 0, 0))
{
    thatWall = instance_position(x, y, parentWall);
    whileStop = 0;
    
    while (!collision_point(x, y, parentWall, 0, 0))
    {
        y += (ysp / 10);
        x += (xsp / 10);
        whileStop += 1;
        
        if (whileStop > 100)
            break;
    }
    
    if (object_get_parent(thatWall.object_index) == 84)
    {
        if (thatWall.wallHp > 0)
        {
            thatWall.wallHp -= bdmg;
            
            if (!bConsistent)
                instance_destroy();
        }
    }
    else if (!bWave)
    {
        scrEffectSpawn(x, y, hitWallFx, 0.5, 0, -10000);
        scrSmokefx(x, y, 1, 0);
        soundPlay(15, 30, 0, 1);
        instance_destroy();
    }
    
    if (bExplode && !bWave)
        instance_create(x, y, bulletExplosion1);
}
else if (place_meeting(x, y, parentShootableThing))
{
    thatThing = instance_place(x, y, parentShootableThing);
    
    if (thatThing.objHp > 0)
    {
        thatThing.objHp -= bdmg;
        scrFlashballfx(x, y, 1, 0, 0);
        
        if (!bConsistent)
            instance_destroy();
    }
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
