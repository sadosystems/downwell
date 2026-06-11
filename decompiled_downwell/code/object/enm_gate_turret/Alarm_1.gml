myPoof = instance_create(xx - (8 * sign(xsp)), yy, pooferBullet);
pldir = point_direction(x, y, global.plx, global.ply);

if (pldir > 180)
    pldir = 90;

if (pldir > 135)
    pldir = 135;
else if (pldir < 45)
    pldir = 45;
else
    plDir = 90;

myPoof.ebDir = pldir;
myPoof.ebSpeed = 1.8;
shotCount += 1;

if (shotCount < 3)
{
    emitTimer = 10;
}
else
{
    shotCount = 0;
    emitTimer = 60;
}

alarm[1] = emitTimer;
