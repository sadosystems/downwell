event_inherited();
bulletThrough = 0;
normalSpr = 343;
stunSpr = 344;
deadSpr = 344;
mask_index = sprite_index;

if (global.area == 5)
    image_yscale = 1;

decclRate = random_range(0.975, 0.99);
boost = 0;
image_index = irandom(image_number - 1);
ehp = 25;
movesp = 0.7;
xsp = movesp * choose(1, -1);
ysp = movesp * -image_yscale;
emitTimer = 45;
xx = x;
yy = y;
money = 6;
imgSp = random_range(0.1, 0.2);
image_speed = imgSp;
xscaleXsp();

if (global.easter == 1)
{
    global.easter = 2;
    instance_create(x, y, enmJellofish);
    instance_destroy();
}
