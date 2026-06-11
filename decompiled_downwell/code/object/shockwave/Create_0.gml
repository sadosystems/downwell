event_inherited();
bulPropertyCheck();
image_speed = 0;
bWave = 0;
allSet = 0;
animation = 0;
image_index = 0;
xsp = 0;
ysp = 0;
imgSp = random_range(0.4, 0.6);
bSpeed += random_range(-global.pBulSpecial[0], 0);
declSp = 0.8;
decelerate = 0;
decelerateSp = 0;
decTimer = global.pBulSpecial[1];

if (global.pugLasersight)
    decTimer += floor(decTimer / 3);

alarm[0] = decTimer;
