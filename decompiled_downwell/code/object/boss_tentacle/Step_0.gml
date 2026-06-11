if (active)
{
    if (place_meeting(x, y, objPlayer_n))
    {
        scrTypicalDamage(1, 0, -2);
        scrFjump(0, -2);
        
        with (objPlayer_n)
        {
            ysp = 3;
            nonAuto = 1;
        }
        
        fallback = 1;
        alarm[0] = 90;
    }
    
    if (!fallback)
        targety = global.ply;
    else
        targety = global.ply - 160;
    
    if (y < (body.y - bodyDistance))
        y += ((body.y - bodyDistance - y) / 50);
    
    if (entering == 1)
    {
        if (x > ((room_width / 2) - 8))
        {
        }
        else
        {
            entering = 2;
            xsp = 0;
            scrSShake(8, 6);
            
            repeat (4)
                emitSmoke(160, y + 16, 0 + random_range(-90, 0), random_range(1, 5));
            
            soundPlayOL(222, 80, 0, 1, "boss");
            momentDelay();
            
            repeat (5)
                instance_create(176, y + 16, breakablesDebris);
        }
        
        if (x < 400)
        {
            repeat (2)
                instance_create(304, y + 16, breakablesDebris);
            
            repeat (2)
                instance_create(304, y + 8, breakablesDebris);
        }
        
        x += xsp;
    }
    else if (entering == 2)
    {
        xsp += 0.0025;
        
        if (xsp > 0.5)
            xsp = 0.5;
        
        if (x > (room_width / 2))
        {
            xsp = 0;
            entering = 0;
            x = room_width / 2;
        }
        
        x += xsp;
    }
    
    if (entering != 1)
    {
        if (!global.death)
        {
            if (!FINALBOSS.opening)
                y += 0.25;
        }
    }
}
