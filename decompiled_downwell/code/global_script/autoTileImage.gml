function autoTileImage(arg0)
{
    checkTarget = arg0;
    i = 0;
    
    if (place_meeting(x, y - 16, checkTarget))
        i += 1;
    
    if (place_meeting(x + 16, y, checkTarget))
        i += 2;
    
    if (place_meeting(x, y + 16, checkTarget))
        i += 4;
    
    if (place_meeting(x - 16, y, checkTarget))
        i += 8;
    
    image_index = i;
}
