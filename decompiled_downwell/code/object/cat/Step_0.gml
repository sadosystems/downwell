if (!pickedUp)
{
    if (place_meeting(x, y, objPlayer_n))
    {
        if ((xdir * (x - objPlayer_n.x)) >= 4)
        {
            if (image_xscale == objPlayer_n.image_xscale)
            {
                objPlayer_n.noDraw = 1;
                global.noControl = 1;
                global.noShot = 0;
                pickedUp = 1;
                image_xscale = objPlayer_n.image_xscale;
                xx = objPlayer_n.x;
                roundPosition();
                sprite_index = sprPlayerCatPickup;
                image_index = 0;
                image_speed = 0;
                alarm[1] = 5;
            }
        }
    }
}

if (!pickedUp)
{
    if (walking)
    {
        sprite_index = sprCatWalk;
        xsp = walksp * xdir;
        scrCheckCollisionWith(57);
        
        if (xcollision != 0)
        {
            xsp = 0;
            xdir *= -1;
        }
    }
    else
    {
        xsp = 0;
        sprite_index = sprCatMeow;
        image_index = meow;
    }
}

if (pickedUp)
{
    xsp = 0;
    
    if (image_index > (image_number - 1))
    {
        image_speed = 0;
        objPlayer_n.noDraw = 0;
        global.noControl = 0;
        
        with (objPlayer_n)
        {
            global.ending = 1;
            spriteRun = 30;
            spriteAir = 41;
            spriteIdle = 36;
            spriteShoot = 41;
            global.pGunType = 0;
            bStatUpdate(global.pGunType, global.pGunLevel);
            sprite_index = spriteIdle;
        }
        
        instance_destroy();
    }
}

xx += xsp;
xscaleXsp();
roundPosition();
