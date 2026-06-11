if (!allSet)
{
    xsp = lengthdir_x(smokesp, smokedir);
    ysp = lengthdir_y(smokesp, smokedir);
    image_speed = smokesp * random_range(0.05, 0.13);
    allSet = 1;
}

xx += xsp;
yy += ysp;
x = round(xx);
y = round(yy);
xsp *= 0.9;
ysp *= 0.9;

if (nocol)
{
    if (point_distance(xstart, ystart, x, y) > 16)
        nocol = 0;
}
