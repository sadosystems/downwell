scrInitSpeed();
itemType = choose(0, 1);

if (itemType == 1)
    sprite_index = sprBonusBtry;
else
    sprite_index = sprBonusHeart;

moving = 0;
alarm[3] = 30;
alarm[4] = 10;
image_speed = 0;
px = 1;
xsp = 0;
ysp = -2;
ugrav = 0.1;
obtainable = 0;
addAmount = 1;
unobtime = 10;
obtime = 0;
distime = 120;
alarm[0] = unobtime;
dissapearing = 0;
dflash = -1;
grounded = 0;
yy = y;
