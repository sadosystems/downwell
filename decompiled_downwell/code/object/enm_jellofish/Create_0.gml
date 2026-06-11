event_inherited();
bulletThrough = 0;
x = 240;
normalSpr = 345;
stunSpr = 346;
deadSpr = 344;
direction = point_direction(x, y, global.eplx, global.eply);
mask_index = sprite_index;

if (global.area == 5)
    image_yscale = 1;

decclRate = random_range(0.975, 0.99);
boost = 0;
image_index = irandom(image_number - 1);
ehp = 100;
movesp = 0.7;
xsp = movesp * choose(1, -1);
ysp = movesp * -image_yscale;
emitTimer = 45;
xx = x;
yy = y;
money = 6;
imgSp = 0.08;
image_speed = imgSp;
xscaleXsp();
