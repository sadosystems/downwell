function scrPlayerPlatformCollision(arg0)
{
    checkTarget = arg0;
    workaroundx = round(xx) + (ceil(abs(xsp)) * sign(xsp));
    workaroundy = round(yy) + (ceil(abs(ysp)) * sign(ysp));
    xcollision = 0;
    ycollision = 0;
    
    if (place_meeting(workaroundx, yy, checkTarget))
    {
        xx = round(xx);
        whileLimit = xsp;
        moveAmount = 0;
        
        while (true)
        {
            if (place_meeting(xx + moveAmount + sign(xsp), yy, checkTarget))
                break;
            else
                moveAmount += sign(xsp);
            
            if (abs(moveAmount) >= abs(whileLimit))
            {
                moveAmount = 0;
                break;
            }
        }
        
        xx += moveAmount;
        xcollision = sign(xsp);
    }
    
    if (place_meeting(xx, workaroundy, checkTarget))
    {
        yy = round(yy);
        whileLimit = ysp;
        moveAmount = 0;
        
        while (true)
        {
            if (place_meeting(xx, yy + moveAmount + sign(ysp), checkTarget))
                break;
            else
                moveAmount += sign(ysp);
            
            if (abs(moveAmount) >= abs(whileLimit))
            {
                moveAmount = 0;
                break;
            }
        }
        
        yy += moveAmount;
        ycollision = sign(ysp);
    }
    
    if (xcollision == 0)
    {
        if (ycollision == 0)
        {
            if (place_meeting(workaroundx, workaroundy, checkTarget))
            {
                yy = round(yy);
                xx = round(xx);
                whileLimit = ysp;
                xmoveAmount = 0;
                ymoveAmount = 0;
                
                while (true)
                {
                    if (place_meeting(xx + xmoveAmount + sign(xsp), yy + ymoveAmount, checkTarget))
                        break;
                    else if (place_meeting(xx + xmoveAmount + sign(xsp), yy + ymoveAmount, parentWall))
                        break;
                    else
                        xmoveAmount += sign(xsp);
                    
                    if (place_meeting(xx + xmoveAmount, yy + ymoveAmount + sign(ysp), checkTarget))
                        break;
                    else if (place_meeting(xx + xmoveAmount, yy + ymoveAmount + sign(ysp), parentWall))
                        break;
                    else
                        ymoveAmount += sign(ysp);
                    
                    if (abs(ymoveAmount) >= abs(whileLimit))
                    {
                        xmoveAmount = 0;
                        ymoveAmount = 0;
                        break;
                    }
                }
                
                yy += ymoveAmount;
                xx += xmoveAmount;
                ycollision = sign(ysp);
                xcollision = sign(xsp);
            }
        }
    }
}
