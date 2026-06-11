if (global.area == 5)
    scrOutofview();

if (checked == 1)
{
    if (surrounded)
    {
        tile_add(739, 48, 48, 16, 16, x - 8, y - 8, 100);
        instance_destroy();
    }
    else
    {
        checked = 2;
    }
    
    if (deactivate)
        instance_deactivate_object(self);
}

if (!checked)
{
    checkThing = 60;
    i = 0;
    
    if (place_meeting(x, y - 16, checkThing))
        i += 1;
    
    if (place_meeting(x + 16, y, checkThing))
        i += 2;
    
    if (place_meeting(x, y + 16, checkThing))
        i += 4;
    
    if (place_meeting(x - 16, y, checkThing))
        i += 8;
    
    if (isPillar == 1)
    {
        switch (i)
        {
            case 0:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
                i = 15;
                break;
            
            case 1:
            case 3:
            case 4:
            case 5:
                i = 7;
                break;
        }
        
        if (i == 3)
            i = 7;
    }
    else if (isPillar == -1)
    {
        switch (i)
        {
            case 0:
            case 2:
            case 3:
            case 6:
            case 7:
            case 10:
            case 11:
            case 14:
                i = 15;
                break;
            
            case 1:
            case 4:
            case 5:
            case 9:
                i = 13;
                break;
        }
    }
    
    if (i == 15 && !surrounded)
    {
        lightUpLeft = 1;
        lightUpRight = 1;
        lightDownLeft = 1;
        lightDownRight = 1;
        chkdist = 16;
        
        if (position_meeting(x - chkdist, y - chkdist, objWall_n))
            lightUpLeft = 0;
        
        if (position_meeting(x + chkdist, y - chkdist, objWall_n))
            lightUpRight = 0;
        
        if (position_meeting(x - chkdist, y + chkdist, objWall_n))
            lightDownLeft = 0;
        
        if (position_meeting(x + chkdist, y + chkdist, objWall_n))
            lightDownRight = 0;
        
        if (!lightUpLeft && !lightUpRight && !lightDownLeft && !lightDownRight)
        {
            surrounded = 1;
            checked = 1;
        }
    }
    
    image_index = i;
    
    if (global.area == 4)
    {
        switch (image_index)
        {
            case 2:
            case 6:
            case 0:
            case 10:
            case 14:
            case 8:
            case 12:
                if (choose(0, 0, 1))
                    instance_create(x, y - 16, limboShard);
                
                break;
        }
    }
    
    if (global.area == 0)
    {
        switch (image_index)
        {
            case 2:
            case 0:
            case 10:
            case 14:
            case 8:
                image_index = 14;
                break;
        }
        
        if (image_index != 14)
        {
            if (image_index != 6)
            {
                if (image_index != 12)
                    image_index = 15;
            }
        }
    }
    
    checked = 1;
}
