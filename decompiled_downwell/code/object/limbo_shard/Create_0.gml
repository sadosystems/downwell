xsp = irandom_range(-2, 2);
ysp = choose(0, -1, -1, -1, -2, -2, -3);
ascendsp = random_range(0.1, 0.6);
shardLimit = 16;

if (global.lowSpec)
    shardLimit = 5;

xx = x;
yy = y;
ugrav = 0.08;
ugravhard = 0.1;
imgSp = choose(0, 0.01, 0.05) * choose(-1, 1);
image_speed = imgSp;
image_index = random(7);
dissapearing = 0;
dflash = -1;
noTouch = 0;
