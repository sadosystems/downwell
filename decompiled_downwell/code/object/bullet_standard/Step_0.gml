if (!allSet)
{
    bDir += random_range(-bdirRand, bdirRand);
    xsp = lengthdir_x(bSpeed, bDir);
    ysp = lengthdir_y(bSpeed, bDir);
    image_angle = bDir;
    scrEffectSpawn(x, y, mFlash, 0.5, bDir, 0);
    allSet = 1;
}

scrBulCheckSolid();
x += xsp;
y += ysp;
