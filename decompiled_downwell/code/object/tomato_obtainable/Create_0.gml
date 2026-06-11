scrInitSpeed();
maxNotify = 0;
image_speed = 0.3;
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

yy = y;
