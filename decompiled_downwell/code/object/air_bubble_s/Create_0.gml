xsp = random_range(-0.5, 0.5);
ysp = choose(-1, -1, -1, -2, -2, -3);
atr = 16;
attracted = 0;
obtainable = 0;
alarm[1] = 10;
ascendsp = random_range(0.2, 0.6);

if (place_meeting(x, y, parentWall))
{
    move_snap(16, 16);
    wl = 0;
    rr = 4;
    rrmax = 32;
    
    while (true)
    {
        rx = irandom_range(-rr, rr);
        ry = irandom_range(-rr, rr);
        
        if (!place_meeting(x + rx, y + ry, parentWall))
            break;
        
        if (rr <= 32)
            rr += 4;
        
        wl += 1;
        
        if (wl > 32)
        {
            instance_destroy();
            break;
        }
    }
    
    x += rx;
    y += ry;
}

xx = x;
yy = y;
ugrav = 0.08;
ugravhard = 0.1;
imgSp = random_range(0.03, 0.05);
image_speed = imgSp;
image_index = random(7);
alarm[2] = 5;
dissapearing = 0;
dflash = -1;
noTouch = 1;
