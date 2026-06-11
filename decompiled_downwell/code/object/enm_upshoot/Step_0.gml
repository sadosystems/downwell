if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            image_index = 0;
            hitStun = 1;
            alarm[1] = 5;
        }
        
        xsp = lengthdir_x(movesp, direction);
        ysp = lengthdir_y(movesp, direction);
        scrCheckCollisionWith(57);
        
        if (xcollision != 0 || ycollision != 0)
        {
            if (xcollision != 0)
            {
                xsp = 0;
                
                if (xcollision == 1)
                {
                    if (direction > 180)
                        direction -= ((direction - 270) * 2);
                    else
                        direction += ((90 + direction) * 2);
                }
                else if (xcollision == -1)
                {
                    if (direction > 180)
                        direction += ((270 - direction) * 2);
                    else
                        direction -= ((direction - 90) * 2);
                }
            }
            
            if (ycollision != 0)
            {
                ysp = 0;
                
                if (ycollision == 1)
                {
                    if (direction > 90 && direction <= 270)
                        direction -= ((direction - 180) * 2);
                    else
                        direction += ((360 - direction) * 2);
                }
                else if (ycollision == -1)
                {
                    if (direction > 90 && direction <= 270)
                        direction += ((180 - direction) * 2);
                    else
                        direction -= (direction * 2);
                }
            }
        }
        
        if (xsp != 0)
            image_xscale = sign(xsp);
    }
    else
    {
        ysp += global.grav;
        scrCheckCollisionWith(57);
        
        if (xcollision != 0)
            xsp *= -0.3;
        
        if (ycollision != 0)
        {
            if (ycollision == -1)
                ysp = 0;
            else
                alive = 0;
        }
    }
    
    if (alive)
    {
        xx += xsp;
        yy += ysp;
        x = round(xx);
        y = round(yy);
    }
}
else
{
    image_speed = 0;
}

if (ehp <= 0)
    active = 0;

if (!alive)
{
    scrEnemyDeath();
    
    repeat (4)
        emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
    
    scrFlashballfx(x, y, 1, 0, 0);
    scrCurrencySpawn(money);
    audio_play_sound(sndPlip, 0, 0);
    instance_create(x, y, Spore);
    instance_destroy();
}

if (hitStun)
    sprite_index = sprBoringball;
else
    sprite_index = sprBoringball;
