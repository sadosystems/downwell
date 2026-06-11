scrOutofview();

if (autoTile)
{
    if (!checked)
    {
        i = 0;
        
        if (place_meeting(x, y - 16, objBox_n))
            i += 1;
        
        if (place_meeting(x + 16, y, objBox_n))
            i += 2;
        
        if (place_meeting(x, y + 16, objBox_n))
            i += 4;
        
        if (place_meeting(x - 16, y, objBox_n))
            i += 8;
        
        material = "wood";
        image_index = i;
        checked = 1;
    }
}
