function scrUpButtonFunctions()
{
    if (global.dUp)
    {
        if (!global.interactable)
        {
            if (grounded)
            {
                if (tinyJumpThreshold)
                {
                    if (!place_meeting(x, y - 16, parentWall))
                        tinyJumpThreshold = 0;
                }
                
                if (tinyJumpThreshold && !hardLandJump)
                {
                    scrPlayerShootN();
                    tinyJumpThreshold = 0;
                }
                else
                {
                    scrJump();
                }
            }
            else if (hardLandJump)
            {
                if (place_meeting(xx, yy + 8, sParentSolid))
                    scrJump();
                else
                    hardLandJump = 0;
            }
            else if (global.spinJumping)
            {
                if (global.dLeft)
                {
                    if (place_meeting(x + wallKickLength, y, subparentSolidWall))
                    {
                        myJumpFx = instance_create(x, y, objJumpFx);
                        soundPlay(choose(86), 80, 0, 1);
                        jumpShootLock = 1;
                        grounded = 0;
                        image_index = 0;
                        alarm[10] = 30;
                        tinyJumpThreshold = 1;
                        hardLandJump = 0;
                        ysp = -wallkicksp;
                        xsp = -maxsp;
                        global.spinJumping = 0;
                        myJumpFx.image_angle = 90;
                    }
                }
                else if (global.dRight)
                {
                    if (place_meeting(x - wallKickLength, y, subparentSolidWall))
                    {
                        myJumpFx = instance_create(x, y, objJumpFx);
                        soundPlay(choose(86), 80, 0, 1);
                        jumpShootLock = 1;
                        grounded = 0;
                        image_index = 0;
                        alarm[10] = 30;
                        tinyJumpThreshold = 1;
                        hardLandJump = 0;
                        ysp = -wallkicksp;
                        xsp = maxsp;
                        global.spinJumping = 0;
                        myJumpFx.image_angle = 270;
                    }
                }
            }
        }
        
        if (!jumpShootLock)
        {
            if (global.spinJumping != 0)
                global.spinJumping = 0;
            
            if (global.yayJumping != 0)
                global.yayJumping = 0;
        }
    }
    
    if (global.dUpRel)
    {
        if (ysp < 0)
            ysp = ysp / 2;
        
        if (jumpShootLock)
            jumpShootLock = 0;
        
        if (global.pBulDelayKill == 1)
            shotDelay = 0;
        
        if (wet == 2)
            wet = 0;
        
        if (nonAuto)
            nonAuto = 0;
        
        jetpacking = 0;
    }
    
    if (global.dUpHeld)
    {
        if (!grounded)
        {
            if (!shotDelay && !jumpShootLock && !(!global.pugGravsuit && wet) && !hardLandJump && !nonAuto && !global.noShot)
                scrPlayerShootN();
            
            if (global.pugJet && !nonAuto)
            {
                if (jetFrame < jetMax)
                {
                    if (global.stammo <= 0)
                    {
                        jetpacking = 1;
                        jetFrame += 0.5;
                        jetPower = 0 + (3 * (jetFrame / jetMax));
                        
                        if (ysp > jetPower)
                            ysp = jetPower;
                    }
                    else
                    {
                        jetpacking = 0;
                    }
                }
                else
                {
                    jetpacking = 0;
                }
            }
        }
    }
}
