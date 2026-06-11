rotAmt += (random_range(0.2, 1) * choose(1, -1));

if (abs(rotAmt) > 2)
    rotAmt = 2 * sign(rotAmt);

rotSwitchAlarm = random_range(30, 180);
alarm[2] = rotSwitchAlarm;

if (y > global.ply)
    direction = 90;
