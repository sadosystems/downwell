if (!checked)
{
    if (place_meeting(x - 8, y, crumbleBlock))
    {
        if (place_meeting(x + 8, y, crumbleBlock))
            image_index = 1;
        else
            image_index = 2;
    }
    else if (place_meeting(x + 8, y, crumbleBlock))
    {
        image_index = 0;
    }
    else
    {
        sprite_index = sprCrumbleBlock;
    }
    
    checked = 1;
}

if (place_meeting(x, y - 1, objPlayer_n) && objPlayer_n.grounded)
    touched = 1;

if (touched && !active)
{
    active = 1;
    image_speed = disapSpeed;
    touched = 1;
    image_index = 0;
    sprite_index = sprCrumbleBlock;
}

if (active == 1)
{
    active = 2;
    
    if (instance_place(x - 8, y, crumbleBlock))
    {
        neighborBlock = instance_place(x - 8, y, crumbleBlock);
        
        with (neighborBlock)
        {
            if (!active)
            {
                active = 1;
                image_speed = disapSpeed;
                touched = 1;
                sprite_index = sprCrumbleBlock;
                image_index = 0;
            }
        }
    }
    
    if (instance_place(x + 8, y, crumbleBlock))
    {
        neighborBlock = instance_place(x + 8, y, crumbleBlock);
        
        with (neighborBlock)
        {
            if (!active)
            {
                active = 1;
                image_speed = disapSpeed;
                touched = 1;
                sprite_index = sprCrumbleBlock;
                image_index = 0;
            }
        }
    }
}
