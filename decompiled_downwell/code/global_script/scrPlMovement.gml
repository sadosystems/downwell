function scrPlMovement()
{
    jumped = 0;
    global.plx = xx;
    global.ply = yy;
    
    if (global.pugDecoy)
    {
        if (global.ballooning)
        {
            global.eplx = global.ballooning.x;
            global.eply = global.ballooning.y;
        }
        else
        {
            global.eplx = global.plx;
            global.eply = global.ply;
        }
    }
    else
    {
        global.eplx = global.plx;
        global.eply = global.ply;
    }
    
    if (!global.noControl && !napping)
    {
        if (!global.death)
        {
            if (global.dLeft)
            {
                if (xsp >= 0 && grounded && !global.dRight && !wallColliding)
                {
                    myLandFx = instance_create(xx, yy, objJumpSmallerFx);
                    myLandFx.emitTo = -1;
                }
                
                xsp -= moveaccl;
                
                if (grounded)
                {
                    if (xsp > 0)
                        xsp -= (sign(xsp) * 2);
                    
                    if (!global.gInWater)
                    {
                        if (xsp < -maxsp)
                            xsp = -maxsp;
                    }
                    else if (xsp < -waterMaxsp)
                    {
                        xsp = -waterMaxsp;
                    }
                }
                else
                {
                    if (xsp > 0)
                        xsp -= (sign(xsp) * 1);
                    
                    if (!global.gInWater)
                    {
                        if (xsp < -airMaxsp)
                            xsp = -airMaxsp;
                    }
                    else if (xsp < -waterAirMaxsp)
                    {
                        xsp = -waterAirMaxsp;
                    }
                }
                
                if (place_meeting(xx - 2, yy, parentWall))
                    againstWall = -1;
                
                if (!global.spinJumping)
                    image_xscale = -1;
            }
            
            if (global.dRight)
            {
                if (xsp <= 0 && grounded && !global.dLeft && !wallColliding)
                {
                    myLandFx = instance_create(xx, yy, objJumpSmallerFx);
                    myLandFx.emitTo = 1;
                }
                
                xsp += moveaccl;
                
                if (grounded)
                {
                    if (xsp < 0)
                        xsp -= (sign(xsp) * 2);
                    
                    if (!global.gInWater)
                    {
                        if (xsp > maxsp)
                            xsp = maxsp;
                    }
                    else if (xsp > waterMaxsp)
                    {
                        xsp = waterMaxsp;
                    }
                }
                else
                {
                    if (xsp < 0)
                        xsp -= (sign(xsp) * 1);
                    
                    if (!global.gInWater)
                    {
                        if (xsp > airMaxsp)
                            xsp = airMaxsp;
                    }
                    else if (xsp > waterAirMaxsp)
                    {
                        xsp = waterAirMaxsp;
                    }
                }
                
                if (place_meeting(xx + 2, yy, parentWall))
                    againstWall = 1;
                
                if (!global.spinJumping)
                    image_xscale = 1;
            }
            
            if (!(global.dLeft || global.dRight))
            {
                if (grounded)
                    xsp -= (sign(xsp) * decclsp);
                else
                    xsp -= (sign(xsp) * airdeccl);
                
                againstWall = 0;
                
                if (abs(xsp) < 0.3)
                    xsp = 0;
                
                if (grounded)
                {
                    whoaCheckx = 5 * image_xscale;
                    
                    if (!collision_line(x + whoaCheckx, y, x + whoaCheckx, y + 16, sParentSolid, 0, 0))
                        onEdge = 1;
                    else
                        onEdge = -1;
                }
                else
                {
                    onEdge = -1;
                }
            }
            else
            {
                onEdge = -1;
            }
            
            if (global.dLeft && global.dRight)
                xsp = 0;
            
            scrUpButtonFunctions();
            
            if (fjump)
            {
                grounded = 0;
                ysp = -enemybounce;
                fjump = 0;
            }
        }
    }
    
    if (global.noControl)
        xsp = 0;
    
    if (grounded)
    {
        if (airstatus)
        {
            global.achAreaNoLand = 0;
            global.achNoLand = 0;
            airstatus = 0;
            
            if (!groundRoom())
            {
                if (!global.bgmOn)
                    global.bgmOn = 1;
                
                levelBeginCue();
            }
            
            myLandFx = instance_create(xx, yy, objJumpSmallerFx);
            myLandFx.emitTo = sign(xsp);
            
            if (hardLand)
            {
                if ((global.dLeft || global.dRight) && !(global.playStyle == 3))
                {
                    if (!global.gInWater)
                        scrFjump(0, 1);
                    else
                        scrFjump(0, 0.75);
                    
                    hardLandJump = 1;
                    alarm[6] = 15;
                    soundPlay(88, 30, 0, 1);
                }
                else
                {
                    soundLand();
                }
                
                hardLand = 0;
            }
            else
            {
                soundLand();
            }
            
            if (noChargeMsg)
                noChargeMsg = 0;
            
            global.spinJumping = 0;
            global.yayJumping = 0;
            airborneShot = 0;
        }
        
        if (!global.pTimeStop)
            comboDone();
        
        jetpacking = 0;
        jetFrame = 0;
        secondjump = 0;
        outofwaterBoost = 0;
        yy = round(yy);
        wet = 0;
        
        if (sprite_index == spriteRun && global.playStyle != 2 && global.playStyle != 3)
        {
            if (floor(image_index) == 1 || floor(image_index) == 5)
            {
                if (floor(image_index - imgsprun) != floor(image_index))
                    soundFootstep();
            }
        }
    }
    
    if (!grounded)
    {
        if (global.pFired)
        {
            if (!airborneShot)
                airborneShot = 1;
            
            image_index = 0;
        }
        
        airstatus = 1;
        
        if (global.fallspeed > 3)
            prvfallsp = global.fallspeed;
    }
    
    if (xx < 160)
        global.outOfMain = 0;
    else
        global.outOfMain = 1;
    
    if (global.death)
    {
        if (!prvdeath)
        {
            instance_create(xx, yy, objDeathFlashFx);
            soundPlay(89, 100, 0, 0);
            audio_sound_gain(global.bgm, 0, 0);
            audio_stop_sound(global.bgm);
            saveStats();
            alarm[0] = room_speed * 1.5;
        }
        
        if (global.dUp)
        {
            forceSkip += 1;
            
            if (forceSkip == 3)
            {
                if (deathani >= -1)
                {
                    deathani = -2;
                    instance_create(0, 0, DeathMenu);
                }
            }
        }
        
        xsp -= (sign(xsp) * 0.08);
        
        if (ysp < 0)
            ysp = ysp / 2;
        
        prvdeath = global.death;
    }
    
    playerSpriteControl();
    xspFinal = xsp + xspCarry;
    yspFinal = ysp + yspCarry;
    xspCarry = 0;
    yspCarry = 0;
}
