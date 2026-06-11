if (!allSet)
{
    while (true)
    {
        if (!place_meeting(x, y - chainLength, parentWall))
            chainLength += 16;
        else
            break;
        
        if (chainLength > 160)
            break;
    }
    
    allSet = 1;
}

if (!place_meeting(x, y + 16, parentWall))
    image_index = 1;
