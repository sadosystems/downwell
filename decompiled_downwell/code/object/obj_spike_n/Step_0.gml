if (!set)
{
    if (place_meeting(x, y + 8, parentWall))
    {
        image_angle = 0;
        set = 1;
    }
    else if (place_meeting(x + 8, y, parentWall))
    {
        image_angle = 90;
        set = 2;
    }
    else if (place_meeting(x - 8, y, parentWall))
    {
        image_angle = 270;
        set = 3;
    }
    else if (place_meeting(x, y - 8, parentWall))
    {
        image_angle = 180;
        set = 4;
    }
    else
    {
        instance_destroy();
    }
}
