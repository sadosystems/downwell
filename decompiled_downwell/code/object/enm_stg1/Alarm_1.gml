myBul = instance_create(x, y, enmbul1);
myBul.ebDir = point_direction(x, y, global.plx, global.ply) + random_range(-5, 5);
shotCount += 1;

if (shotCount < shotMax)
{
    alarm[1] = shotInterval;
    shot = 1;
}
