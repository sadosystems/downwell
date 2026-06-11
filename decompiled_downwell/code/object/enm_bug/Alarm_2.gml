if (active)
{
    enmdir += (irandom(90) * choose(-1, 1));
    alarm[2] = irandom_range(30, 90);
}
else
{
    enmdir = point_direction(x, y, xstart, ystart) + (irandom(30) * choose(-1, 1));
    alarm[2] = irandom_range(5, 60);
}
