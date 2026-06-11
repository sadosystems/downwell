if (!allSet)
{
    bSpeed = 5;
    xsp = lengthdir_x(bSpeed, bDir);
    ysp = lengthdir_y(bSpeed, bDir);
    image_angle = bDir;
    allSet = 1;
}

if (!disregardWall)
    scrBulCheckSolid();

x += xsp;
y += ysp;
ysp *= 0.9;
xsp *= 0.9;

if (abs(xsp + ysp) < 0.7)
    instance_destroy();
