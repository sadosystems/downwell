function scrWallCol()
{
    if (!hardLand && !hardLandJump)
    {
        hardLand = 1;
    }
    else if (hardLand)
    {
        if (ysp < hardLandSp)
            hardLand = 0;
    }
    
    if (grounded)
        ysp = 0;
    
    scrPlayerPlatformCollision(87);
    
    if (ycollision != 0)
    {
        if (ycollision == 1)
        {
            if (!place_meeting(xx, yy, parentThinwall))
            {
                if (place_meeting(xx, yy + 1, parentThinwall))
                {
                    grounded = 1;
                    ysp = 0;
                }
            }
        }
    }
    
    scrCheckCollisionWith(57);
    
    if (xcollision != 0)
    {
        xsp = 0;
        
        if (xcollision == 1)
        {
            if (global.dRight)
                wallColliding = 1;
        }
        else if (xcollision == -1)
        {
            if (global.dLeft)
                wallColliding = 1;
        }
    }
    else
    {
        wallColliding = 0;
    }
    
    if (ycollision != 0)
    {
        if (ycollision == 1)
        {
            if (place_meeting(xx, yy + 1, parentWall))
            {
                grounded = 1;
                ysp = 0;
            }
        }
        else if (ycollision == -1)
        {
            ysp = 0;
            boxAbove = instance_place(xx, yy - 16, objBox_n);
            
            if (boxAbove)
            {
                with (boxAbove)
                    wallHp = 0;
                
                ysp = 1;
            }
        }
    }
    
    if (grounded)
    {
        if (airstatus)
        {
            if (!global.pTimeStop && xcollision == 0)
                comboDone();
            
            scrRecharge(global.rechargeAmount);
        }
        
        if (place_meeting(xx, yy, parentWall))
        {
            if (!place_meeting(xx, yy - 1, parentWall))
                yy -= 1;
        }
    }
    
    if (!place_meeting(xx, yy + 1, sParentSolid))
    {
        if (grounded == 1)
        {
            grounded = 0;
            ysp += global.grav;
        }
    }
}
