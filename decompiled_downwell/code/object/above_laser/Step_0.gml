if (place_meeting(x, y, objPlayer_n))
{
    scrTypicalDamage(1, 0, -2);
    scrFjump(0, -2);
    
    with (objPlayer_n)
    {
        ysp = 3;
        jumpShootLock = 1;
    }
    
    fallback = 1;
    alarm[0] = 90;
}

if (!fallback)
    targety = global.ply;
else
    targety = global.ply - 160;

ddd = 288;

if (y < (body.y - ddd))
    y += ((body.y - ddd - y) / 15);

if (x != 240)
{
    x += ((240 - x) / 15);
    
    if (abs(x - 240) < 1)
        x = 240;
}

if (!global.pTimeStop)
    y += 0.25;
