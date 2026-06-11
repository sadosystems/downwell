event_inherited();
xsp = random_range(-3, 3);
ysp = random_range(-2, 2);
grounded = 0;

if (!global.pugRip)
    objHp = 0;
else
    hitEffect = 1;

active = 0;
alarm[3] = 8;
hit = 0;
ugrav = 0.1;
ugravhard = 0.2;
explosionFx = 102;
image_speed = choose(-0.5, -0.3, 0, 0.3, 0.5);
disappearing = 0;
dflash = -1;
bounceSnd = -1;
noTouch = 1;
bouncing = 1;
xx = x;
yy = y;
alarm[0] = 180;
alarm[1] = 120;

if (place_meeting(x, y, parentWall) || tile_layer_find(100, x, y))
{
    move_snap(16, 16);
    wl = 0;
    rr = 4;
    rrmax = 32;
    
    while (true)
    {
        rx = irandom_range(-rr, rr);
        ry = irandom_range(-rr, rr);
        
        if (!place_meeting(x + rx, y + ry, parentWall) && !tile_layer_find(100, x, y))
            break;
        
        if (rr <= 32)
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
