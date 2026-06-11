function scrTypicalItemGravity()
{
    ysp += ugrav;
    
    if (place_meeting(x + xsp, y, sParentSolid))
    {
        xsp *= -1;
        xsp *= 0.7;
    }
    
    if (place_meeting(x, y + ysp, sParentSolid))
    {
        if (ysp <= 0)
        {
            ysp *= 0;
        }
        else if (ysp > 0)
        {
            if (place_meeting(x, y + 1, sParentSolid))
            {
                ysp = 0;
                grounded = 1;
            }
            else
            {
                coldis = 0;
                i = 1;
                
                while (!place_meeting(x, y + i, sParentSolid))
                {
                    coldis += 1;
                    i += 1;
                    
                    if (i > 16)
                        break;
                }
                
                ysp = coldis;
            }
        }
    }
    
    if (grounded)
        xsp = 0;
    
    x += xsp;
    y += ysp;
    y = round(y);
}
