if (!initialCheck)
{
    for (i = 16; !collision_line(x, y, x, y + i, parentWall, 0, 0); i += 16)
        instance_create(x, y + i, objWaterUnder_n);
    
    if (place_meeting(x + 8, y, parentWall))
        image_index = 1;
    else if (place_meeting(x - 8, y, parentWall))
        image_index = 0;
    else
        image_index = choose(2, 3);
    
    initialCheck = 1;
    
    if (place_meeting(x, y - 8, objWall_n))
    {
        instance_destroy();
        instance_create(x, y, objWaterUnder_n);
    }
}
