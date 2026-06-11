if (!allSet)
{
    allSet = 1;
    
    if (place_meeting(x - 16, y, parentWall))
        latched = 1;
    else if (place_meeting(x + 16, y, parentWall))
        latched = -1;
    else
        instance_destroy();
    
    leng2wall = 0;
    
    if (latched != 0)
    {
        while (true)
        {
            if (collision_line(x, y, x + leng2wall, y, parentWall, 0, 0))
                break;
            else
                leng2wall += (16 * latched);
            
            if (abs(leng2wall) > 160)
            {
                allSet = 0;
                instance_destroy();
                break;
            }
        }
    }
}

if (allSet)
{
    if (collision_line(x - (8 * latched), y, (x - (8 * latched)) + leng2wall, y, objPlayer_n, 0, 0))
        scrTypicalDamage(1, 3, 2);
    
    if (!place_meeting(x - (16 * latched), y, parentWall))
        instance_destroy();
}
