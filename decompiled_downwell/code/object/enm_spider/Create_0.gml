event_inherited();
normalSpr = sprite_index;
stunSpr = 241;
deadSpr = 291;
weby = ystart - 8;
webLength = irandom_range(32, 64);
maxsp = 1;
boingAccl = 0.1;

if (collision_line(x, y, x, y - 16, parentWall, 0, 0))
{
    hanging = 1;
}
else if (collision_line(x, y, x, y - 24, parentThinwall, 0, 0))
{
    hanging = 1;
    weby = ystart - 20;
}
else
{
    hanging = 0;
}

if (hanging)
{
    if (collision_line(x, y, x, y + 16, sParentSolid, 0, 0))
    {
        hanging = 0;
    }
    else
    {
        while (collision_line(x, y, x, y + webLength + 8, sParentSolid, 0, 0))
            webLength -= 2;
    }
}

if (hanging)
    mask_index = sprSpiderHang;
else
    mask_index = sprSpiderIdle;

landed = 0;
walking = -1;
walksp = 0.5;
walkdir = 1;
grounded = 0;
ehp = 15;
xsp = 0;
ysp = 0;
randomCycle = irandom_range(60, 180);
alarm[1] = randomCycle;
xx = x;
yy = y;
money = 1;
imgSp = 0.25;
image_speed = imgSp;
