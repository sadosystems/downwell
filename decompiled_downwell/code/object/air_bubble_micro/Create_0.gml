xsp = random_range(-0.5, 0.5);
ysp = choose(0, -1, -1, -1, -2, -2);
ascendsp = random_range(0.1, 0.6);

if (global.hardMode)
    sprite_index = sprBubbleMicroRed;

xx = x;
yy = y;
ugrav = 0.08;
ugravhard = 0.1;
imgSp = random_range(0.01, 0.05);
image_speed = imgSp;
image_index = random(7);
alarm[2] = 30;
dissapearing = 0;
dflash = -1;
noTouch = 1;
