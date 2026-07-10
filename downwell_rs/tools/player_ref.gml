// ==== global_script/scrControlInput.gml ====
function scrControlInput()
{
    global.padUp = gamepad_button_check_pressed(0, gp_face1);
    global.padUpHeld = gamepad_button_check(0, gp_face1);
    global.padUpRel = gamepad_button_check_released(0, gp_face1);
    global.padCancel = gamepad_button_check_pressed(0, gp_face2);
    
    if (global.isPaused || global.death)
    {
        if (!global.padLeft && !global.padRight)
        {
            padLeftPressed = gamepad_button_check_pressed(0, gp_padl) || gamepad_button_check_pressed(0, gp_padu);
            padRightPressed = gamepad_button_check_pressed(0, gp_padr) || gamepad_button_check_pressed(0, gp_padd);
        }
        else
        {
            padLeftPressed = 0;
            padRightPressed = 0;
        }
        
        global.padLeft = gamepad_button_check(0, gp_padl) || gamepad_button_check(0, gp_padu);
        global.padRight = gamepad_button_check(0, gp_padr) || gamepad_button_check(0, gp_padd);
        
        if (gamepad_axis_value(0, gp_axislh) != 0)
        {
            if (gamepad_axis_value(0, gp_axislh) > 0)
            {
                global.padRight = 1;
                
                if (!analogPressed)
                {
                    padRightPressed = 1;
                    analogPressed = 1;
                }
            }
            else
            {
                global.padLeft = 1;
                
                if (!analogPressed)
                {
                    padLeftPressed = 1;
                    analogPressed = 1;
                }
            }
        }
        else if (gamepad_axis_value(0, gp_axislv) != 0)
        {
            if (gamepad_axis_value(0, gp_axislv) > 0)
            {
                global.padRight = 1;
                
                if (!analogPressed)
                {
                    padRightPressed = 1;
                    analogPressed = 1;
                }
            }
            else
            {
                global.padLeft = 1;
                
                if (!analogPressed)
                {
                    padLeftPressed = 1;
                    analogPressed = 1;
                }
            }
        }
        else
        {
            analogPressed = 0;
        }
    }
    else
    {
        global.padLeft = gamepad_button_check(0, gp_padl);
        padLeftPressed = gamepad_button_check_pressed(0, gp_padl);
        global.padRight = gamepad_button_check(0, gp_padr);
        padRightPressed = gamepad_button_check_pressed(0, gp_padr);
        
        if (gamepad_axis_value(0, gp_axislh) != 0)
        {
            if (gamepad_axis_value(0, gp_axislh) > 0)
            {
                global.padRight = 1;
                
                if (!analogPressed)
                {
                    padRightPressed = 1;
                    analogPressed = 1;
                }
            }
            else
            {
                global.padLeft = 1;
                
                if (!analogPressed)
                {
                    padLeftPressed = 1;
                    analogPressed = 1;
                }
            }
        }
        else
        {
            analogPressed = 0;
        }
    }
    
    global.dUp = keyboard_check_pressed(vk_space) || global.padUp || global.dTouchUp || vkUpPressed;
    global.dUpHeld = keyboard_check(vk_space) || global.padUpHeld || global.dTouchUpHeld || vkUpHeld;
    global.dUpRel = keyboard_check_released(vk_space) || global.padUpRel || global.dTouchUpRel || vkUpReleased;
    global.dLeft = keyboard_check(ord("A")) || keyboard_check(ord("Q")) || global.padLeft || global.dTouchLeft || vkLeftHeld;
    global.dLeftPressed = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(ord("Q")) || padLeftPressed || global.dTouchLeftPressed || vkLeftPressed;
    global.dRight = keyboard_check(ord("D")) || global.padRight || global.dTouchRight || vkRightHeld;
    global.dRightPressed = keyboard_check_pressed(ord("D")) || padRightPressed || global.dTouchRightPressed || vkRightPressed;
    global.anyInput = global.dUp || global.dLeftPressed || global.dRightPressed;
    vkLeftPressed = 0;
    vkRightPressed = 0;
    vkUpPressed = 0;
    vkUpReleased = 0;
}

// ==== global_script/scrPlMovement.gml ====
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

// ==== global_script/scrUpButtonFunctions.gml ====
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

// ==== global_script/scrJump.gml ====
function scrJump()
{
    if (!napping)
    {
        if (global.pugRocket)
        {
            myRocketBlast = instance_create(x, y + 4, bulletBlast);
            myRocketBlast.sprite_index = spSplosion1;
            soundPlay(344, 60, 0, 1);
            emitSmoke(global.plx, global.ply + 4, 15, 3);
            emitSmoke(global.plx, global.ply + 4, 165, 3);
        }
        
        if (!global.gInWater)
            ysp = -jumpsp;
        else
            ysp = -jumpspWater;
        
        jumped = 1;
        
        if (global.gInWater)
        {
            soundPlayOL(choose(313, 314), 80, 0, 1, "waterThings");
            
            repeat (2)
                instance_create(x, y, airBubbleMicro);
        }
        else
        {
            soundPlay(choose(86), 80, 0, 1);
            myJumpFx = instance_create(x, y, objJumpFx);
        }
        
        jumpShootLock = 1;
        grounded = 0;
        hardLandJump = 0;
        
        if (global.dLeft || global.dRight)
        {
            global.spinJumping = 1;
            
            if (global.ending)
                global.spinJumping = 0;
        }
        
        image_index = 0;
    }
}

// ==== global_script/scrWallCol.gml ====
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

// ==== global_script/scrPlayerPlatformCollision.gml ====
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

// ==== global_script/scrCheckCollisionWith.gml ====
function scrCheckCollisionWith(arg0)
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
                    else
                        xmoveAmount += sign(xsp);
                    
                    if (place_meeting(xx + xmoveAmount, yy + ymoveAmount + sign(ysp), checkTarget))
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

// ==== global_script/playerSpriteControl.gml ====
function playerSpriteControl()
{
    if (!global.death)
    {
        if (!napping)
        {
            if (grounded)
            {
                if (xsp == 0)
                {
                    if (!onEdge)
                    {
                        sprite_index = spriteIdle;
                        image_speed = imgspstand;
                    }
                    else
                    {
                        sprite_index = sprPlayerBalancing;
                        image_speed = 0.25;
                    }
                }
                else
                {
                    if (sprite_index != spriteRun)
                        image_index = 0;
                    
                    image_speed = imgsprun;
                    sprite_index = spriteRun;
                }
            }
            else if (!grounded)
            {
                if (global.spinJumping != 0)
                {
                    sprite_index = spriteSpin;
                    image_speed = imgspspin * global.spinJumping;
                    
                    if (global.dLeft)
                    {
                        if (place_meeting(x + wallKickLength, y, subparentSolidWall))
                        {
                            sprite_index = sprPlayerWall;
                            image_index = 0;
                            image_xscale = -1;
                        }
                    }
                    else if (global.dRight)
                    {
                        if (place_meeting(x - wallKickLength, y, subparentSolidWall))
                        {
                            sprite_index = sprPlayerWall;
                            image_index = 0;
                            image_xscale = 1;
                        }
                    }
                }
                else if (global.yayJumping != 0)
                {
                    if (sprite_index != spriteYay)
                    {
                        sprite_index = spriteYay;
                        image_index = 0;
                        image_speed = 0.2 * global.yayJumping;
                    }
                    
                    if (image_index >= (image_number - 1))
                    {
                        image_index = image_number - 1;
                        image_speed = 0;
                    }
                    else
                    {
                        image_speed = 0.5 * global.yayJumping;
                    }
                }
                else if (airborneShot)
                {
                    sprite_index = spriteShoot;
                    
                    if (image_index <= 3)
                        image_speed = imgspshoot;
                    else
                        image_speed = 0;
                }
                else
                {
                    sprite_index = spriteAir;
                    image_speed = 0;
                    
                    if (ysp < 0)
                    {
                        image_index = 0;
                        
                        switch (floor(abs(ysp)))
                        {
                            case 3:
                            case 2:
                                image_index = 0;
                                break;
                            
                            case 1:
                            case 0:
                                image_index = 1;
                                break;
                        }
                    }
                    else
                    {
                        image_index = 4;
                        
                        switch (floor(abs(ysp)))
                        {
                            case 0:
                                image_index = 2;
                                break;
                            
                            case 1:
                                image_index = 3;
                                break;
                            
                            case 2:
                                image_index = 4;
                                break;
                        }
                    }
                }
            }
        }
        else if (napping)
        {
            sprite_index = napSprite;
            image_speed = napImgSp;
            image_xscale = napXscale;
            xx = napx;
            yy = napy;
            
            if (global.anyInput && !global.noControl)
            {
                napping = 0;
                
                if (grounded)
                {
                    soundLand();
                    myLandFx = instance_create(xx, yy, objJumpSmallerFx);
                    myLandFx.emitTo = 0;
                }
            }
        }
    }
    else if (global.death)
    {
        sprite_index = sprPlDead;
        image_speed = 0;
        image_index = 0;
        
        if (abs(xsp) < 0.5)
        {
            xsp = 0;
            
            if (grounded)
            {
                if (!deathani)
                    image_index = 1;
            }
        }
    }
}

// ==== global_script/scrAimControl.gml ====
function scrAimControl()
{
    if (global.dLeft)
    {
        aimAngle -= global.aimAngleAccl;
        
        if (aimAngle > 0)
            aimAngle -= global.aimAngleDccl;
    }
    
    if (global.dRight)
    {
        aimAngle += global.aimAngleAccl;
        
        if (aimAngle < 0)
            aimAngle += global.aimAngleDccl;
    }
    
    if (!(global.dLeft || global.dRight))
    {
        if (aimAngle != 0)
            aimAngle -= (sign(aimAngle) * global.aimAngleDccl);
        
        if (abs(aimAngle) < 2)
            aimAngle = 0;
    }
    
    if (abs(aimAngle) > global.aimAngleLimit)
        aimAngle = global.aimAngleLimit * sign(aimAngle);
}

// ==== global_script/scrGravity_n.gml ====
function scrGravity_n()
{
    if (global.area == 4)
    {
        finalMaxgrav = 6;
        finalGrav = global.grav;
    }
    else if (global.gInWater)
    {
        finalMaxgrav = 6;
        finalGrav = global.grav / 1.4;
    }
    else if (global.playStyle == 3)
    {
        finalMaxgrav = global.maxgrav;
        finalGrav = global.grav / 1.5;
    }
    else
    {
        finalMaxgrav = global.maxgrav;
        finalGrav = global.grav;
    }
    
    if (global.ballooning)
        finalMaxgrav -= 1;
    
    ysp += finalGrav;
    
    if (ysp >= finalMaxgrav)
        ysp = finalMaxgrav;
}

// ==== global_script/scrCheckInWater.gml ====
function scrCheckInWater()
{
    if (place_meeting(xx, yy, parentWater))
    {
        if (!global.gInWater)
        {
            with (objControlerN)
                alarm[2] = 90;
            
            breath = -15;
            alarm[8] = 1;
            inWater = 1;
            global.gInWater = 1;
            sp = 0;
            
            while (place_meeting(xx, yy - sp, parentWater))
                sp += 1;
            
            repeat (24)
                instance_create(xx + choose(-2, -1, 0, 1, 2), yy - sp, fxSplash);
            
            soundPlayOL(307, 85, 0, 1, "waterThings");
            
            if (ysp > 0.5)
                ysp = 0.5;
        }
    }
    else
    {
        if (global.gInWater)
        {
            repeat (24)
            {
                with (instance_create(xx + choose(-2, -1, 0, 1, 2), yy, fxSplash))
                    ysp = random(3);
            }
            
            if (!global.death)
                soundPlayOL(1, 85, 0, 1, "waterThings");
            
            inWater = 0;
            global.gInWater = 0;
            wet = 0;
            alarm[4] = 1;
        }
        
        global.gInWater = 0;
    }
}

// ==== global_script/scrPlayerShootN.gml ====
function scrPlayerShootN()
{
    muzzlex = x;
    muzzley = y + 4;
    shotAngle = 270 + aimAngle;
    global.spinJumping = 0;
    
    if (global.stammo > 0)
    {
        global.achNoShot = 0;
        scrSShake(global.pBulScreenShake, global.pBulScreenShakeDur);
        scrShotSound();
        
        if (ysp > global.pBulRecoil)
            ysp = global.pBulRecoil;
        
        if (global.ending)
            ysp = -2;
        
        scrPlayerEmitBullet(muzzlex, muzzley, shotAngle);
        
        if (global.pugLasersight)
            myBullet.bdirRand = 0;
        
        alarm[2] = abs(global.pBulRof);
        
        if (global.pBulRof < 0)
            nonAuto = 1;
        
        instance_create(x, y, bulletCasing);
        global.pFired = 1;
        global.stammo -= global.pBulConRate;
        
        if (global.ending)
        {
            global.stammo = global.ammo;
            
            if (global.ply < (__view_get(e__VW.YView, 0) - 64))
            {
                if (global.ending != 2)
                {
                    global.ending = 2;
                    global.noControl = 1;
                }
                
                with (objPlayer_n)
                    ysp = -3;
                
                if (global.ending == 2)
                {
                    bulGain = audio_sound_get_gain(global.pBulSound);
                    bulGain *= 0.95;
                    audio_sound_gain(global.pBulSound, bulGain, 0);
                    
                    if (bulGain < 0.02)
                    {
                        global.ending = 3;
                        goalStop = 1;
                        instance_create(0, 0, endingFadeOut);
                    }
                }
            }
        }
        
        if (global.stammo <= 0)
        {
            emitSmoke(global.plx, global.ply + 4, 315, 4);
            emitSmoke(global.plx, global.ply + 4, 225, 4);
            scrRisingText(global.plx, global.ply, emptyText);
            soundPlay(26, 90, 0, 1);
            global.stammo = 0;
            noChargeMsg = 1;
            nonAuto = 1;
        }
        
        if (global.pBulBurst)
        {
            if (global.pBulBurstRate > 0)
            {
                if (burstCount < global.pBulBurstAmount)
                {
                    alarm[3] = global.pBulBurstRate;
                    burstCount += 1;
                }
                else
                {
                    burstCount = 0;
                }
            }
            else if (global.pBulBurstRate == 0)
            {
                for (i = 0; i < global.pBulBurstAmount; i += 1)
                    scrPlayerEmitBullet(muzzlex, muzzley, shotAngle);
            }
        }
    }
    else if (jetFrame)
    {
        if (jetFrame < jetMax)
        {
            if (ysp > 0)
            {
                ysp = 0;
                jetFrame += 10;
            }
        }
        
        alarm[2] = 16;
    }
    else
    {
        emitSmoke(global.plx, global.ply + 4, 315, 4);
        emitSmoke(global.plx, global.ply + 4, 225, 4);
        soundPlay(26, 90, 0, 1);
        noAmmoYsp = 3;
        
        if (ysp > noAmmoYsp)
            ysp = noAmmoYsp;
        
        if (!noChargeMsg)
        {
            scrRisingText(global.plx, global.ply, "EMPTY!");
            noChargeMsg = 1;
        }
        
        alarm[2] = 16;
    }
    
    shotDelay = 1;
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}

// ==== global_script/scrPlayerEmitBullet.gml ====
function scrPlayerEmitBullet(arg0, arg1, arg2)
{
    emitx = arg0 + shootLeg;
    emity = arg1;
    emitdir = arg2;
    shootLeg *= -1;
    scrEffectSpawn(emitx, y + 12, global.pBulMuzzle, 0.5, emitdir, -60000);
    myBullet = instance_create(emitx, emity, global.pBulObject);
    myBullet.bDir = emitdir;
    
    if (global.pBulSpType == 1)
    {
        for (i = 1; i <= global.pBulSp1; i += 1)
        {
            myBullet = instance_create(emitx, emity, global.pBulObject);
            myBullet.bDir = emitdir + (global.pBulSp2 * i);
            myBullet = instance_create(emitx, emity, global.pBulObject);
            myBullet.bDir = emitdir - (global.pBulSp2 * i);
        }
    }
    else if (global.pBulSpType == 2)
    {
        for (i = 1; i <= global.pBulSp1; i += 1)
        {
            myBullet = instance_create(emitx + (global.pBulSp2 * i), emity - 2, global.pBulObject);
            myBullet.bDir = emitdir;
            myBullet = instance_create(emitx - (global.pBulSp2 * i), emity - 2, global.pBulObject);
            myBullet.bDir = emitdir;
        }
    }
}

// ==== global_script/scrSShake.gml ====
function scrSShake(arg0, arg1)
{
    shakeAmt = arg0;
    shakeDur = arg1;
    camMain.camShake = 1;
    
    if (camMain.camShakeAmt < shakeAmt)
        camMain.camShakeAmt = shakeAmt;
    
    if (camMain.alarm[0] < shakeDur)
        camMain.alarm[0] = shakeDur;
}

// ==== global_script/scrFjump.gml ====
function scrFjump(arg0, arg1)
{
    xfjump = arg0;
    yfjump = arg1;
    yfjumpdef = 2.7;
    
    if (yfjump == 0)
        yfjump = yfjumpdef;
    
    global.spinJumping = 1;
    scrRecharge();
    objPlayer_n.grounded = 0;
    
    if (xfjump != 0)
        objPlayer_n.xsp = xfjump;
    
    objPlayer_n.ysp = -yfjump;
}

// ==== global_script/scrRecharge.gml ====
function scrRecharge()
{
    if (global.stammo < global.ammo)
    {
        global.stammo = global.ammo;
        
        if (global.stammo > global.ammo)
            global.stammo = global.ammo;
        
        scrEffectSpawn(global.plx, global.ply, 111, 1, 0, -50500);
        myFx.image_xscale = 0.75;
        myFx.image_yscale = 0.75;
        soundPlay(27, 90, 0, 1);
        scrSShake(1, 2);
        
        with (objControlerN)
            meterJiggle = 4;
    }
    
    with (objPlayer_n)
        jetFrame = 0;
}

// ==== global_script/comboDone.gml ====
function comboDone()
{
    if (global.comboCount >= 5)
    {
        instance_create(xx, __view_get(e__VW.YView, 0) + 64 + 64, comboRewardText);
        momentDelay();
        
        if (global.comboCount >= 10)
        {
            steamAchGet(UnknownEnum.Value_4);
            
            if (global.comboCount >= 30)
            {
                steamAchGet(UnknownEnum.Value_5);
                
                if (global.comboCount >= 100)
                    steamAchGet(UnknownEnum.Value_14);
            }
        }
    }
    
    if (global.comboCount > global.highCombo)
        global.highCombo = global.comboCount;
    
    if (global.highCombo > global.recordMaxCombo)
    {
        global.recordMaxCombo = global.highCombo;
        ini_open("save.ini");
        ini_write_real("stats", "recordMaxCombo", global.recordMaxCombo);
        ini_close();
    }
    
    global.comboCount = 0;
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_5,
    Value_14 = 14
}

// ==== global_script/playerDraw.gml ====
function playerDraw()
{
    if (!goalStop && !noDraw)
    {
        draw_set_halign(fa_center);
        
        if (global.gemStreak >= global.gemStreakThreshold && !global.death)
        {
            afterImageAmount = afterImageNumber * (global.gemStreakTimer / global.gemStreakTimerStart);
            
            if (afterImageAmount > afterImageNumber)
                afterImageAmount = afterImageNumber;
            
            afterImageDrawAmount = round(afterImageAmount);
            
            for (i = afterImageDrawAmount; i >= 0; i -= 1)
            {
                aiba = irandom_range(-1, 1);
                aibay = irandom_range(-2, 1);
                aiShader = 3;
                vy4shader = shader_get_uniform(aiShader, "vy");
                shader_set(aiShader);
                shader_set_uniform_f(vy4shader, __view_get(e__VW.YView, 0));
                draw_sprite_ext(afterImage[i][0], afterImage[i][1], afterImage[i][3] + aiba, afterImage[i][4] + aibay, afterImage[i][2], image_yscale, 0, c_white, 1);
                shader_reset();
            }
        }
        
        if (!dFlash)
        {
            if (global.playerHp == 1)
            {
                flickerTime += 1;
                flick = 0;
                
                if (flickerTime >= flickerAt)
                {
                    shader_set(shaderPlayerRed);
                    
                    if (flickerTime >= (flickerAt + flickerDur))
                        flickerTime = 0;
                    
                    draw_sprite_ext(sprite_index, image_index, x + irandom_range(-2, 2), y + irandom_range(-1, 1), image_xscale, image_yscale, 0, c_white, image_alpha);
                    draw_sprite_ext(sprite_index, image_index, x + irandom_range(-2, 2), y + irandom_range(-1, 1), image_xscale, image_yscale, 0, c_white, image_alpha);
                    shader_reset();
                }
                else
                {
                    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
                }
            }
            else
            {
                draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
            }
        }
        
        if (global.pugLasersight)
        {
            d2wx = 0;
            d2wy = 0;
            ll = 270 + aimAngle;
            
            while (true)
            {
                if (collision_line(x, y, x + d2wx, y + d2wy, parentWall, 0, 0))
                    break;
                else if (collision_line(x, y, x + d2wx, y + d2wy, subparentEnemy, 0, 0))
                    break;
                
                d2wy += lengthdir_y(8, ll);
                d2wx += lengthdir_x(8, ll - xsp);
                
                if ((y + d2wy) > (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)))
                    break;
            }
            
            draw_line_colour(x, y + 8, x + d2wx, y + d2wy, c_red, c_red);
        }
        
        if (jetpacking)
        {
            switch (floor(jetFrame / (jetMax / 3)))
            {
                case 0:
                    jetSprite = 21;
                    break;
                
                case 1:
                    jetSprite = 22;
                    break;
                
                case 2:
                    jetSprite = 23;
                    break;
            }
            
            draw_sprite(jetSprite, jetFrame, x, y + 16);
        }
        
        if (global.gInWater)
        {
            oxyx = __view_get(e__VW.XView, 0) + 80;
            oxyy = __view_get(e__VW.YView, 0) + 104;
            oxyMetery = __view_get(e__VW.HView, 0) * (global.oxygen / 100);
            oxyBubbler = 16 * (global.oxygen / 100);
            oxyCircii = 15 - (15 * (global.oxygen / 100));
            
            if (global.oxygen > 100)
                oxyCircii = 0;
            
            draw_set_color(c_white);
            
            if (global.oxygen > 0)
            {
                if (oxyGetStun)
                {
                    oxySpr = 726;
                    oxyGetStun -= 1;
                    
                    if (oxyCircii > 0)
                        oxyCircii -= 1;
                }
                else
                {
                    oxySpr = 725;
                }
                
                draw_sprite(oxySpr, oxyCircii, x, y - 4);
            }
        }
        
        if (global.comboCount >= 5)
            drawComboNumber(x, y - 11, global.comboCount);
    }
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}

// ==== global_script/soundLand.gml ====
function soundLand()
{
    landOn = 0;
    landOn = instance_place(x, y + 2, sParentSolid);
    
    if (landOn && !global.death && !napping)
    {
        sfxIndex = 0;
        
        switch (landOn.material)
        {
            case "breakable":
                sfxIndex = 0;
                break;
            
            case "thin":
                sfxIndex = 1;
                break;
            
            case "foliage":
                sfxIndex = 2;
                break;
            
            case "rock":
                sfxIndex = 3;
                break;
            
            case "metal":
                sfxIndex = 4;
                break;
        }
        
        if (!audio_is_playing(sfxGunRecharge))
            soundPlayOL(global.sfxJl[sfxIndex][irandom_range(1, global.sfxJl[sfxIndex][0])], 60, 0, 1, "footsteps");
    }
}

// ==== global_script/soundFootstep.gml ====
function soundFootstep()
{
    landOn = 0;
    landOn = instance_place(x, y + 2, sParentSolid);
    
    if (landOn)
    {
        sfxIndex = 0;
        
        switch (landOn.material)
        {
            case "breakable":
                sfxIndex = 0;
                break;
            
            case "thin":
                sfxIndex = 1;
                break;
            
            case "foliage":
                sfxIndex = 2;
                break;
            
            case "rock":
                sfxIndex = 3;
                break;
            
            case "metal":
                sfxIndex = 4;
                break;
        }
        
        footstepsnd = -1;
        footstepsnd = soundPlayOL(global.sfxFs[sfxIndex][irandom_range(1, global.sfxFs[sfxIndex][0])], 60, 0, 1, "footsteps");
        
        if (global.pTimeStop || groundRoom() || atPit)
        {
            sndgain = audio_sound_get_gain(sndsnd);
            sndgain *= 1;
            audio_sound_gain(sndsnd, sndgain, 0);
        }
        else
        {
            sndgain = audio_sound_get_gain(sndsnd);
            sndgain *= 0.7;
            audio_sound_gain(sndsnd, sndgain, 0);
        }
    }
}

// ==== global_script/emitSmoke.gml ====
function emitSmoke(arg0, arg1, arg2, arg3)
{
    mySmoke = instance_create(arg0, arg1, fxSmoke);
    mySmoke.smokedir = arg2;
    mySmoke.smokesp = arg3;
}

// ==== global_script/emitMovingFx.gml ====
function emitMovingFx(arg0, arg1, arg2, arg3, arg4, arg5)
{
    myFx = instance_create(arg0, arg1, parentMovingFx);
    myFx.sprite_index = arg2;
    myFx.image_speed = arg3;
    myFx.image_angle = arg4;
    myFx.xsp = lengthdir_x(arg5, arg4);
    myFx.ysp = lengthdir_y(arg5, arg4);
}

// ==== global_script/scrRisingText.gml ====
function scrRisingText(arg0, arg1, arg2)
{
    if (room != rmTrailer)
    {
        basex = arg0;
        basey = arg1;
        drawText = arg2;
        myRisingText = instance_create(basex, basey, fxRisingText);
        myRisingText.text = drawText;
    }
}

// ==== global_script/scrPlayerInit.gml ====
function scrPlayerInit()
{
    activatey = 0;
    emptyText = langString("gunEmpty");
    global.firstLand = 0;
    napping = 0;
    
    if (groundRoom())
    {
        napping = 1;
        groundPlayerSet();
        styleUpdate(global.playStyle);
    }
    
    if (global.area != 0)
        loadCheck();
    
    jetpacksnd = -1;
    oxyGetStun = 0;
    noDraw = 0;
    flickerTime = 0;
    flickerAt = 45;
    flickerDur = 6;
    flick = 0;
    atPit = 0;
    jetpacking = 0;
    jetFrame = 0;
    jetMax = 90;
    onEdge = 0;
    global.achNoDamage = 1;
    global.achNoLand = 1;
    global.achNoSideroom = 1;
    global.achNoKill = 1;
    global.achNoShot = 1;
    global.achAreaNoDamage = 1;
    global.achAreaNoLand = 1;
    forceSkip = 0;
    wallKickLength = 3;
    shootLeg = -1;
    
    if (global.pugLasersight)
        shootLeg = 0;
    
    if (global.pugDecoy)
        instance_create(x, y, decoyBalloon);
    
    if (room == rmMain)
    {
        if (global.level == 1)
        {
            if (global.bgm != 193)
                audio_stop_sound(global.bgm);
        }
        else
        {
            objControlerN.alarm[2] = 60;
        }
    }
    
    pinchEmitTimer = 10;
    alarm[5] = pinchEmitTimer;
    
    if (global.hardMode)
        global.oxygenDepRate = 7;
    else
        global.oxygenDepRate = 13;
    
    alarm[9] = global.oxygenDepRate;
    alarm[8] = 60;
    breath = 0;
    breathTimer = 120;
    tinyJumpThreshold = 0;
    goalStop = 0;
    global.gemStreakTimer = global.gemStreakTimerStart + 120;
    global.puDepletionRate = 0;
    inked = 0;
    xx = x;
    yy = y;
    global.gemGet = 0;
    gemGetText = 0;
    gemLeaking = 0;
    global.oxygen = global.oxygenMax;
    
    with (objControlerN)
    {
        powerUpMem = global.oxygen;
        meterGained = 0;
    }
    
    afterImageOn = 1;
    
    if (afterImageOn)
    {
        afterImageNumber = 8;
        
        for (i = 0; i <= afterImageNumber; i += 1)
        {
            afterImage[i][0] = 31;
            afterImage[i][1] = 0;
            afterImage[i][2] = 1;
            afterImage[i][3] = x;
            afterImage[i][4] = y;
        }
        
        afterImageInterval = 1;
        alarm[7] = afterImageInterval;
    }
    
    global.heartGoal = 0;
    checkStop = 0;
    gemTextFlash = -1;
    xx = round(x);
    yy = round(y);
    xsp = 0;
    ysp = 0;
    xspCarry = 0;
    yspCarry = 0;
    xspFinal = 0;
    yspFinal = 0;
    moveaccl = 0.2;
    maxsp = 2;
    airMaxsp = 2.5;
    waterMaxsp = 2;
    waterAirMaxsp = 2.3;
    decclsp = 0.4;
    jumpsp = 4.4;
    
    if (global.pugRocket)
        jumpsp = 5;
    
    if (global.playStyle == 3)
        jumpsp *= 0.85;
    
    wallkicksp = 4;
    jumpspWater = 3.8;
    airaccl = 1.2;
    airdeccl = 0.1;
    aimAngle = 0;
    global.droneNum = 0;
    global.ballooning = 0;
    global.playerDamaged = 0;
    global.stammo = global.ammo;
    atk = 1;
    burstCount = 0;
    grounded = 0;
    hardLandSp = 1.2;
    hardLand = 0;
    hardLandJump = 0;
    airstatus = 1;
    wet = 0;
    jumpShootLock = 1;
    alarm[5] = 30;
    noChargeMsg = 0;
    airborneShot = 0;
    image_xscale = global.plxDir;
    shotDelay = 1;
    alarm[2] = 30;
    nonAuto = 0;
    wallColliding = 0;
    againstWall = 0;
    inWater = 0;
    outofwaterBoost = 0;
    deathani = 0;
    prvdeath = 0;
    fjump = 0;
    secondjump = 0;
    enemybounce = 2.7;
    prvfallsp = 0;
    messySecondJump = 0;
    image_speed = 0.3;
    dFlash = -1;
    
    if (global.pugDrone)
    {
        instance_create(x, y, objDrone);
        global.droneNum = 1;
        
        if (global.pugDrone == 2)
        {
            with (instance_create(x, y, objDrone))
            {
                xdir = 180;
                ydir = 180;
            }
        }
    }
    
    spriteIdle = 31;
    spriteRun = 27;
    spriteAir = 37;
    spriteSpin = 1;
    spriteShoot = 3;
    spriteYay = 10;
    mask_index = sprPlayerIdle;
    global.playerSprite = sprite_index;
    global.playerImageSpeed = image_speed;
    global.playerImageIndex = image_index;
    imgsprun = 0.3;
    imgspstand = 0.1;
    imgspspin = 0.3;
    imgspshoot = 0.25;
    styleSet();
}

// ==== object/obj_player_n/Step_0.gml ====
if (global.pFired == 2)
    global.pFired = 0;

if (global.pFired == 1)
    global.pFired = 2;

scrAimControl();

if (global.playerSprite != sprite_index)
    global.playerSprite = sprite_index;

if (global.playerImageSpeed != image_speed)
    global.playerImageSpeed = image_speed;

if (global.playerImageIndex != image_index)
    global.playerImageIndex = image_index;

if (global.playerDamaged)
    dFlash *= -1;
else
    dFlash = -1;

global.falldepth = yy - objDepthMeter.y;

// ==== object/obj_player_n/Step_1.gml ====
if ((__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)) > (activatey - 112))
{
    activatey += 16;
    instance_activate_region(0, 0, room_width, activatey, 1);
}

scrGravity_n();
scrCheckInWater();
scrPlMovement();
scrWallCol();

if (napping)
{
    xsp = 0;
    ysp = 0;
    jumpShootLock = 1;
}

if (jetpacking)
{
    if (!jetpacksnd)
        jetpacksnd = soundPlay(343, 80, 1, 1);
}
else
{
    if (audio_is_playing(jetpacksnd))
        audio_stop_sound(jetpacksnd);
    
    jetpacksnd = -1;
}

if (!goalStop)
{
    if (!global.death && global.bossDead != 2)
    {
        if (room == rmMain)
        {
            if (!place_meeting(x, y, goalTimeField))
                global.gameTime += 1;
        }
    }
    
    yy += ysp;
    xx += xsp;
}

if (global.wrapMode)
{
    if (xx > 320)
        xx = 160;
    else if (xx < 160)
        xx = 320;
}

x = round(xx);
y = round(yy);

if (instance_place(xx, yy, camLocker))
    global.pCamFocus = instance_place(xx, yy, camLocker);
else
    global.pCamFocus = -1;

if (place_meeting(xx, yy, parentInteractable) && xsp == 0 && grounded)
{
    if (instance_place(xx, yy, parentInteractable).interactOk)
    {
        if (!global.interactable)
            global.interactable = 1;
    }
    else if (global.interactable)
    {
        global.interactable = 0;
    }
}
else if (global.interactable)
{
    global.interactable = 0;
}

if (room == rmMain || room == rmTutorialMain)
{
    if (place_meeting(xx, yy, parentTimeField) || xx < 160 || xx > (room_width - 160))
    {
        if (!checkStop)
        {
            checkStop = 1;
            
            if (place_meeting(xx, yy, parentTimeField))
            {
                scrTimeShard();
                scrSShake(2, 2);
            }
        }
    }
    else if (checkStop)
    {
        checkStop = 0;
        scrTimeShard();
    }
}
else if (place_meeting(xx, yy, parentTimeField))
{
    if (!checkStop)
        checkStop = 1;
}
else if (checkStop)
{
    checkStop = 0;
}

if (checkStop == 1)
{
    if (!global.pTimeStop)
    {
        global.pTimeStop = 1;
        instance_create(xx, yy, fxTimeChange);
        
        if (audio_is_playing(global.bgm))
            audio_pause_sound(global.bgm);
        
        global.bgmOn = 0;
        scrTimeShard();
        soundPlay(184, 80, 0, 1);
    }
}
else if (checkStop == 0)
{
    if (global.pTimeStop)
    {
        global.pTimeStop = 0;
        instance_create(xx, yy, fxTimeChange);
        
        if (audio_is_paused(global.bgm))
            audio_resume_sound(global.bgm);
        
        if (audio_is_playing(global.voidWind))
            audio_stop_sound(global.voidWind);
        
        global.bgmOn = 1;
        scrTimeShard();
        soundPlay(185, 80, 0, 1);
        bgmDuck(200, 0.7);
    }
}

if (global.pTimeStop)
{
    if (global.oxygen < 10)
        global.oxygen = 10;
}

if (global.playerHp <= 0)
{
    global.death = 1;
    global.playerHp = 0;
    
    if (!prvdeath)
        deathani = 1;
}

if (!alive)
    global.death = 1;

if (image_xscale != 0)
    global.plxDir = sign(image_xscale);

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}

// ==== object/obj_player_n/Step_2.gml ====
if (global.pHit)
{
    if (global.pHit > 1)
        global.pHit = 0;
    else
        global.pHit += 1;
}

// ==== object/obj_player_n/Alarm_2.gml ====
shotDelay = 0;

// ==== object/obj_player_n/Alarm_6.gml ====
hardLandJump = 0;

// ==== object/obj_player_n/Alarm_10.gml ====
tinyJumpThreshold = 0;

// ==== object/obj_jump_smaller_fx/Create_0.gml ====
image_index = 0;
image_speed = 0.5;
emitTo = 0;

// ==== object/obj_jump_smaller_fx/Draw_0.gml ====
if (emitTo != 1)
    draw_sprite_ext(sprJumpSmallerFx, image_index, x, y, 1, 1, 0, c_white, 1);

if (emitTo != -1)
    draw_sprite_ext(sprJumpSmallerFx, image_index, x, y, -1, 1, 0, c_white, 1);

// ==== object/obj_jump_smaller_fx/Other_7.gml ====
action_kill_object();

// ==== object/obj_jump_fx/Create_0.gml ====
image_index = 0;
image_speed = 0.5;

// ==== object/obj_jump_fx/Draw_0.gml ====
// (missing)

// ==== object/obj_jump_fx/Other_7.gml ====
action_kill_object();

// ==== object/bullet_casing/Create_0.gml ====
event_inherited();
bdmg = 0;
bSpeed = 5;
allSet = 1;
xsp = random_range(-3, -1) * sign(objPlayer_n.image_xscale);
ysp = random_range(-3, 0);
image_speed = choose(-0.5, -0.3, 0, 0.3, 0.5);
alarm[0] = 15;

if (global.pugLeak)
{
    bdmg = 5;
    alarm[0] = 30 * global.pugLeak;
    sprite_index = sprLeakBullet;
}

dFlash = 1;
flashing = 0;
ugrav = 0.08;
ugravhard = 0.2;

// ==== object/bullet_casing/Step_0.gml ====
if (flashing)
    dFlash *= -1;

if (ysp < -1)
    ysp += ugravhard;
else
    ysp += ugrav;

if (place_meeting(x + xsp, y, parentWall))
{
    xsp *= -1;
    xsp *= 0.7;
}

bDir = point_direction(0, 0, xsp, ysp);

if (abs(xsp) < 0.05)
    xsp = sign(xsp) * 0.05;

scrBulCheckSolid();

if (TimeStopBound())
{
    x += xsp;
    y += ysp;
}

// ==== object/bullet_casing/Draw_0.gml ====
if (dFlash)
    draw_self();

// ==== object/cam_main/Create_0.gml ====
roomw = room_width;
sideLocked = 0;
camFocus = 0;
camShake = 0;
camShakeAmt = 0;
endingCamera = 0;
creditSpawn = 0;
memorizey = 0;
camSlowdown = 5;
camSlowdownX = 1;
autoScroll = 0;
daop = 24;

if (groundRoom())
    daop = -32;

camPointy = objPlayer_n.y;
camPointx = objPlayer_n.x;
camAccly = ((camPointy + daop) - y) / 5;
camAcclx = (80 - x) / 10;
chasePlayer = 1;
centered = 1;
freeCam = 0;
xAhead = 16;
roomEnd = -1;
x = camPointx;
y = camPointy;
xx = x;
yy = y;

// ==== object/cam_main/Step_0.gml ====
if (!global.death)
{
    if (!freeCam)
    {
        if (global.plx > 160 && global.plx < (roomw - 160))
        {
            if (memorizey != 0)
                memorizey = 0;
            
            camPointx = global.plx + (global.plxDir * xAhead);
            
            if (camPointx < 240)
                camPointx = 240;
            else if (camPointx > (roomw - 160 - 80))
                camPointx = roomw - 160 - 80;
            
            if (autoScroll)
            {
                if (camPointy < (global.ply + daop))
                {
                    chasePlayer = 1;
                }
                else if (!global.pTimeStop)
                {
                    chasePlayer = 0;
                    camPointy += 0.5;
                }
            }
            
            if (chasePlayer)
                camPointy = global.ply + daop;
            
            if (xx > 160 && xx < (roomw - 160))
            {
                camSlowdown = 5;
                camSlowdownX = 10;
            }
            else
            {
                camSlowdown = 1;
                camSlowdownX = 1;
            }
        }
        else
        {
            camSlowdownX = 1;
            
            if (global.plx < 160)
                camPointx = 80;
            else if (global.plx > (roomw - 160))
                camPointx = roomw - 80;
        }
    }
    else if (freeCam)
    {
        if (memorizey != 0)
            memorizey = 0;
        
        camPointx = global.plx + (global.plxDir * xAhead);
        
        if (camPointx < 80)
            camPointx = 80;
        else if (camPointx > (roomw - 80))
            camPointx = roomw - 80;
        
        if (chasePlayer)
            camPointy = global.ply + daop;
        
        camSlowdown = 5;
        camSlowdownX = 10;
    }
}

if (centered && xAhead)
    xAhead = 0;
else if (!centered && !xAhead)
    xAhead = 16;

if (centered && objPlayer_n.xsp != 0)
{
    centered = 0;
    xAhead = 16;
}

if (sideLocked)
{
    if (!place_meeting(x, y, sideCamLocker))
    {
        camPointy = global.ply + daop;
        yy = camPointy;
        y = camPointy;
        camSlowdown = 1;
        camPointx = global.plx + (global.plxDir * 16);
        
        if (camPointx < 240)
            camPointx = 240;
        else if (camPointx > (roomw - 160 - 80))
            camPointx = roomw - 160 - 80;
        
        xx = camPointx;
        x = camPointx;
        camSlowdownX = 1;
        sideLocked = 0;
    }
}

if (global.pCamFocus)
{
    camPointy = global.pCamFocus.pointery;
    camPointx = global.pCamFocus.pointerx;
    camSlowdownX = 15;
}

if (roomEnd)
{
    if (camPointy > roomEnd)
    {
        camPointy = roomEnd;
        
        if (yy > roomEnd)
            yy = roomEnd;
    }
}

if (endingCamera == 1)
{
    if (daop > -200)
    {
        daop -= 0.5;
    }
    else if (!creditSpawn)
    {
        global.noControl = 1;
        creditSpawn = 1;
        objPlayer_n.xx = 240;
    }
}
else if (endingCamera == 2)
{
    if (daop < 24)
    {
        daop += 0.5;
    }
    else
    {
        daop = 24;
        endingCamera = 3;
        global.noControl = 0;
    }
}

camAcclx = (camPointx - xx) / camSlowdownX;
camAccly = (camPointy - yy) / camSlowdown;
yy += camAccly;
xx += camAcclx;

if (yy < 142)
    yy = 142;

xxFinal = xx;
yyFinal = yy;

if (camShake)
{
    xxFinal = xx + irandom_range(-camShakeAmt / 2, camShakeAmt / 2);
    yyFinal = yy + irandom_range(-camShakeAmt, camShakeAmt);
}

if (!global.ending)
{
    x = round(xxFinal);
    y = round(yyFinal);
}

// ==== object/cam_main/Collision_sideCamLocker.gml ====
if (camPointy != other.y)
{
    camPointy = other.y;
    
    if (!sideLocked)
    {
        yy = other.y;
        y = other.y;
        sideLocked = 1;
    }
}

global.easter = 0;
global.achNoSideroom = 0;

// ==== object/obj_grass/Step_0.gml ====
if (active)
{
    if (objHp <= 0)
    {
        active = 0;
        sprite_index = sprGrassLay;
        mask_index = noMask;
    }
}

