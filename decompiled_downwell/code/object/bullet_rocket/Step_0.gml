if (!allSet)
{
    bDir += random_range(-bdirRand, bdirRand);
    image_angle = bDir;
    allSet = 1;
}

bSpeed += 0.05;

if (bSpeed > maxsp)
    bSpeed = maxsp;

image_angle = bDir;
xsp = lengthdir_x(bSpeed, bDir);
ysp = lengthdir_y(bSpeed, bDir);
x += xsp;
y += ysp;
