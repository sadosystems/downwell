xsp = irandom_range(-2, 2);
ysp = choose(0, -1, -1, -1, -2, -2, -3);
xx = x;
yy = y;
shardLimit = 20;

if (global.lowSpec)
    shardLimit = 3;

ugrav = 0.08;
ugravhard = 0.1;
imgSp = choose(-0.5, -0.3, 0, 0.3, 0.5);
image_speed = imgSp;
image_index = random(7);
alarm[0] = random_range(90, 160);
alarm[1] = 40;
alarm[2] = 30;
dissapearing = 0;
dflash = -1;
noTouch = 1;
