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
