rotAmt = random_range(0.2, 2) * choose(1, -1);
rotSwitchAlarm = random_range(30, 180);
alarm[2] = rotSwitchAlarm;

if (point_distance(x, y, global.plx, global.ply) < 96)
{
    direction = point_direction(x, y, global.plx, global.ply);
    rotAmt = 0;
}
