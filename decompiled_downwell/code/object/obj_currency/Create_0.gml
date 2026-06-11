xsp = random_range(-2, 2);
ysp = random_range(-2, 2);

if (global.area == 5)
    ysp = -random(3);

active = 1;
allSet = 0;
unobtime = 10;
obtime = 180;
distime = 120;
stuckKamo = 0;
bounceGain = 1;
stepRate = 1;
size = 0;
getAmount = 2;
ugrav = 0.035;
ugravhard = 0.2;
umaxgrav = 4;

if (global.area == 3 || global.area == 4)
{
    ugrav /= 4;
    umaxgrav = 0.5;
}

alarm[0] = unobtime;
imgSp = choose(-0.5, -0.3, 0.3, 0.5);
image_speed = imgSp;
suckable = 0;
obtainable = 0;
dissapearing = 0;
dflash = -1;

if (global.ug[10][1])
{
    atr = 48;
    atrsp = 6;
    alarm[3] = 30;
}
else
{
    atr = 24;
    atrsp = 4;
    alarm[3] = 15;
}

attracted = 0;
rotsp = 5;
gemsp = 1;
gemdir = choose(0 + irandom_range(-60, 10), 180 + irandom_range(-10, 60));
bounceSnd = 14;

if (place_meeting(x, y, parentWall) || tile_layer_find(100, x, y))
{
    move_snap(16, 16);
    wl = 0;
    rr = 4;
    rrmax = 32;
    
    while (true)
    {
        rx = irandom_range(-rr, rr);
        ry = irandom_range(-rr, 0);
        
        if (!place_meeting(x + rx, y + ry, parentWall) && !tile_layer_find(100, x, y))
            break;
        
        if (rr <= 64)
            rr += 4;
        
        wl += 1;
        
        if (wl > 32)
            break;
    }
    
    x += rx;
    y += ry;
}

xx = x;
yy = y;
