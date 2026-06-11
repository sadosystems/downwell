event_inherited();
normalSpr = 356;
stunSpr = 344;
deadSpr = 344;
mask_index = sprite_index;
image_yscale = choose(1, -1);

if (global.area == 5)
    image_yscale = 1;

image_index = irandom(image_number - 1);
ehp = 5;
movesp = 1;
xsp = movesp * choose(1, -1);
ysp = movesp * -image_yscale;
emitTimer = 45;
xx = x;
yy = y;
money = 6;
imgSp = 0.05;
image_speed = imgSp;
