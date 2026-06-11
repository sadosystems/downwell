if (!allSet)
{
    bDir += random_range(-bdirRand, bdirRand);
    xsp = lengthdir_x(bSpeed, bDir);
    ysp = lengthdir_y(bSpeed, bDir);
    image_angle = bDir;
    allSet = 1;
}

if (decelerate)
    bSpeed *= declSp;

image_angle = bDir;

if (bSpeed < 3)
{
    if (!animation)
    {
        animation = 1;
        image_speed = imgSp;
    }
}

xsp = lengthdir_x(bSpeed, bDir);
ysp = lengthdir_y(bSpeed, bDir);
scrBulCheckSolid();
x += xsp;
y += ysp;
