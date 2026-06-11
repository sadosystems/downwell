event_inherited();
bdmg = 50;
bConsistent = 1;
bWave = 1;
allSet = 1;
damageStart = 0;
damageStartFrame = 2;
damageEnd = 0;
damageEndFrame = 3;
scrSShake(6, 8);
soundPlayOL(choose(91, 92, 93), 60, 0, 1, "gunwall");
momentDelay();
imgSp = random_range(0.25, 0.4);
image_speed = imgSp;
image_xscale = choose(1, -1);
image_angle = choose(0, 90, 180, 270);

while (collision_point(x, y, bulletExplosion1, 0, 1))
{
    x += choose(-3, 3);
    y += choose(-3, 3);
}
