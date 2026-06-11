if (latched)
{
    if (clockwise)
    {
        switch (direction)
        {
            case 0:
                if (!place_meeting(xx, yy + 1, parentWall))
                    direction = 270;
                else if (place_meeting(xx + movesp, yy, parentWall))
                    direction = 90;
                
                break;
            
            case 90:
                if (!place_meeting(xx + 1, yy, parentWall))
                    direction = 0;
                else if (place_meeting(xx, yy - movesp, parentWall))
                    direction = 180;
                
                break;
            
            case 180:
                if (!place_meeting(xx, yy - 1, parentWall))
                    direction = 90;
                else if (place_meeting(xx - movesp, yy, parentWall))
                    direction = 270;
                
                break;
            
            case 270:
                if (!place_meeting(xx - 1, yy, parentWall))
                    direction = 180;
                else if (place_meeting(xx, yy + movesp, parentWall))
                    direction = 0;
                
                break;
        }
        
        switch (direction)
        {
            case 0:
                xsp = movesp;
                ysp = 0;
                break;
            
            case 270:
                xsp = 0;
                ysp = movesp;
                break;
            
            case 180:
                xsp = -movesp;
                ysp = 0;
                break;
            
            case 90:
                xsp = 0;
                ysp = -movesp;
                break;
        }
        
        if (!place_meeting(xx + 1, yy + 1, parentWall) && !place_meeting(xx - 1, yy - 1, parentWall) && !place_meeting(xx + 1, yy - 1, parentWall) && !place_meeting(xx - 1, yy + 1, parentWall))
            latched = 0;
    }
    
    if (scrInView(0, 0, 0))
    {
        xx += xsp;
        yy += ysp;
    }
}

alarm[1] = framespeed;
