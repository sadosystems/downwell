event_inherited();
bulletImmune = 1;
normalSpr = 303;
stunSpr = 303;
deadSpr = 291;
ehp = 15;
xsp = 0;
ysp = 0;
leapspy = -2;
leapspx = 3;
leapt = 0;
facing = choose(1, -1);
image_xscale = facing;

if (place_meeting(x, y, parentWall))
{
    for (i = 16; i <= 32; i += 16)
    {
        if (!place_meeting(x, y - i, parentWall))
            y -= i;
        else if (!place_meeting(x, y + i, parentWall))
            y += i;
        else if (!place_meeting(x - i, y, parentWall))
            x -= i;
        else if (!place_meeting(x + i, y, parentWall))
            x += i;
    }
    
    if (place_meeting(x, y, parentWall))
        instance_destroy();
}

xx = x;
yy = y;
money = 6;
imgSp = 0.1;
image_speed = imgSp;
