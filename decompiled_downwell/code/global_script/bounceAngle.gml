function bounceAngle()
{
    xcollision = 0;
    ycollision = 0;
    
    if (collision_line(x, y, x + xsp, y, subparentSolidWall, 0, 0))
        xcollision = sign(xsp);
    else if (collision_line(x, y, x, y + ysp, subparentSolidWall, 0, 0))
        ycollision = sign(ysp);
    
    if (collision_line(x, y, x + xsp, y + ysp, subparentSolidWall, 0, 0))
    {
        xcollision = sign(xsp);
        ycollision = sign(ysp);
    }
    
    if (xcollision != 0 || ycollision != 0)
    {
        if (xcollision != 0)
        {
            xsp = 0;
            
            if (xcollision == 1)
            {
                if (bDir > 180)
                    bDir -= ((bDir - 270) * 2);
                else
                    bDir += ((90 + bDir) * 2);
            }
            else if (xcollision == -1)
            {
                if (bDir > 180)
                    bDir += ((270 - bDir) * 2);
                else
                    bDir -= ((bDir - 90) * 2);
            }
        }
        
        if (ycollision != 0)
        {
            ysp = 0;
            
            if (ycollision == 1)
            {
                if (bDir > 90 && bDir <= 270)
                    bDir -= ((bDir - 180) * 2);
                else
                    bDir += ((360 - bDir) * 2);
            }
            else if (ycollision == -1)
            {
                if (bDir > 90 && bDir <= 270)
                    bDir += ((180 - bDir) * 2);
                else
                    bDir -= (bDir * 2);
            }
        }
    }
}
