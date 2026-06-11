event_inherited();
harmful = 1;

if (harmful)
    normalSpr = 278;
else
    normalSpr = 279;

damageSpr = 280;
deadSpr = 281;
ehp = 1;
xsp = 0;
ysp = 0;
clockwise = choose(1, -1);
movesp = 1;
movedir = 0;
framespeed = 2;
alarm[0] = framespeed;
xsp = lengthdir_x(movesp, movedir);
ysp = lengthdir_y(movesp, movedir);
dirRight = direction - 90;
xcheck = lengthdir_x(movesp, dirRight);
ycheck = lengthdir_x(movesp, dirRight);
allSet = 0;
xx = x;
yy = y;
money = 2;
imgSp = 0.2 * clockwise;
image_speed = imgSp;
grounded = 0;
latched = 1;
active = 1;
