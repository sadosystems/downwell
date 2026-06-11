function script83()
{
    if (!hardLand && !hardLandJump)
    {
        if (ysp > 0)
            hardLand = 1;
    }
    else if (hardLand)
    {
        if (ysp < hardLandSp)
            hardLand = 0;
    }
    
    if (grounded)
        ysp = 0;
    
    scrCheckCollisionWith(87);
    
    if (ycollision != 0)
    {
        if (ycollision == 1)
        {
            if (!place_meeting(xx, yy, parentThinwall))
            {
                grounded = 1;
                ysp = 0;
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
        ysp = 0;
        
        if (ycollision == 1)
            grounded = 1;
    }
    
    if (grounded)
    {
        if (airstatus)
            scrRecharge(global.rechargeAmount);
    }
    
    if (!place_meeting(xx, yy + 1, sParentSolid))
        grounded = 0;
}
