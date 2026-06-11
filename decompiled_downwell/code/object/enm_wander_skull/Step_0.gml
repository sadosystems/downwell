if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            direction = 270 + random_range(-20, 20);
            movesp = 2;
            image_index = 0;
            
            if (!angry)
            {
                alarm[3] = 30;
                soundPlayOL(145, 50, 0, 1, "enemymove");
                angry = 1;
                emitMovingFx(x, y, 119, 0.7, 0, 0);
                
                repeat (4)
                    emitMovingFx(xx, yy, 704, random_range(0.1, 0.18), random_range(45, 135), random_range(1, 2));
            }
            else
            {
                soundPlayOL(144, 50, 0, 1, "enemymove");
            }
            
            maxsp = 1.8;
            hitStun = 1;
            alarm[1] = 5;
            normalSpr = 232;
            imgSp = 0.4;
        }
        
        if (!angry)
        {
            if (movesp < maxsp)
                movesp += acclamt;
            
            direction += rotAmt;
            xsp = lengthdir_x(movesp, direction);
            ysp = lengthdir_y(movesp, direction);
        }
        else if (angry)
        {
            playerDir = point_direction(xx, yy, global.eplx, global.eply);
            directionDif = direction - playerDir;
            
            if (directionDif > 180)
                directionDif -= 360;
            else if (directionDif < -180)
                directionDif += 360;
            
            if (abs(directionDif) < moyacone)
            {
                if (movesp < maxsp)
                    movesp += acclamt;
            }
            else if (movesp > 1)
            {
                movesp -= dcclamt;
            }
            
            if (movesp > maxsp)
                movesp -= 0.2;
            
            if (directionDif > 0)
                direction -= rotatesp;
            else if (directionDif < 0)
                direction += rotatesp;
            
            xsp = lengthdir_x(movesp, direction);
            ysp = lengthdir_y(movesp, direction);
        }
        
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
        
        xx += xsp;
        yy += ysp;
    }
    
    x = round(xx);
    y = round(yy);
    
    if (audio_is_playing(myAngryVoice))
    {
        if (y > (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)) || y < __view_get(e__VW.YView, 0))
            audio_sound_gain(myAngryVoice, 0, 500);
        else
            audio_sound_gain(myAngryVoice, 1, 500);
    }
    
    if (audio_is_paused(myAngryVoice))
        audio_resume_sound(myAngryVoice);
}
else
{
    if (audio_is_playing(myAngryVoice))
    {
        audio_pause_sound(myAngryVoice);
        
        if (objPlayer_n.goalStop == 1)
            audio_stop_sound(myAngryVoice);
    }
    
    image_speed = 0;
}

if (ehp <= 0)
    alive = 0;

if (!alive)
{
    scrEnemyDeath();
    
    repeat (4)
        emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
    
    scrFlashballfx(x, y, 1, 0, 0);
    scrCurrencySpawn(money);
    scrDeadBody(deadSpr, takenImpact, 102);
    soundPlayOL(143, 50, 0, 1, "enemymove");
    
    repeat (2)
        instance_create(x, y - 5, breakablesDebris);
    
    audio_stop_sound(myAngryVoice);
    instance_destroy();
}

if (hitStun)
    sprite_index = stunSpr;
else
    sprite_index = normalSpr;

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
