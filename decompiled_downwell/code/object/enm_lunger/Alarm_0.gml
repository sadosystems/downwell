if (!lunge)
{
    lunge = 1;
    direction = point_direction(x, y, global.plx, global.ply);
    xsp = lengthdir_x(movesp, direction);
    ysp = lengthdir_y(movesp, direction);
    alarm[0] = 20;
}
else
{
    lunge = 0;
    alarm[0] = lungeCycle;
}
