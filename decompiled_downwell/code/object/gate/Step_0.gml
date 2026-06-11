if (!set)
{
    if (place_meeting(x, y - 16, Gate))
        placement += 1;
    else if (place_meeting(x, y - 16, GateSwitch))
        placement += 1;
    
    if (place_meeting(x + 16, y, Gate))
        placement += 2;
    else if (place_meeting(x + 16, y, GateSwitch))
        placement += 2;
    
    if (place_meeting(x, y + 16, Gate))
        placement += 4;
    else if (place_meeting(x, y + 16, GateSwitch))
        placement += 4;
    
    if (place_meeting(x - 16, y, Gate))
        placement += 8;
    else if (place_meeting(x - 16, y, GateSwitch))
        placement += 8;
    
    image_index = placement;
    set = 1;
}

if (breaking != 0 && !alarmSet)
{
    alarm[0] = 3;
    alarmSet = 1;
}

if (die)
{
    emitdir = 0;
    
    switch (breaking)
    {
        case 1:
            emitdir = 270;
            break;
        
        case 2:
            emitdir = 180;
            break;
        
        case 3:
            emitdir = 90;
            break;
        
        case 4:
            emitdir = 0;
            break;
    }
    
    emitdir += (180 + random_range(-20, 20));
    imgsprand = random_range(0.3, 0.5);
    emitsp = random_range(0.7, 1.2);
    emitMovingFx(x, y, 85, imgsprand, emitdir, emitsp);
    emitMovingFx(x, y, 96, 0.7, 0, 0);
    target = 0;
    target = instance_place(x, y - 16, Gate);
    
    if (target)
    {
        if (!target.breaking)
            target.breaking = 3;
    }
    
    target = instance_place(x, y + 16, Gate);
    
    if (target)
    {
        if (!target.breaking)
            target.breaking = 1;
    }
    
    target = instance_place(x - 16, y, Gate);
    
    if (target)
    {
        if (!target.breaking)
            target.breaking = 2;
    }
    
    target = instance_place(x + 16, y, Gate);
    
    if (target)
    {
        if (!target.breaking)
            target.breaking = 4;
    }
    
    soundPlay(9, 80, 0, 1);
    instance_destroy();
}
