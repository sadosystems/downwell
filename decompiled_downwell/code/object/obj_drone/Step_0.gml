xdir += 2;
xl = lengthdir_x(24, xdir);
ydir += 2;
yl = lengthdir_y(8, ydir);
x += (((global.plx - x) + xl) / 10);
y += ((((global.ply - y) + yl) - 24) / 10);

if (global.pFired)
{
    if (!droneShooting)
    {
        droneShooting = 1;
        alarm[0] = 4;
    }
}

if (global.bossDead == 2)
    instance_destroy();
