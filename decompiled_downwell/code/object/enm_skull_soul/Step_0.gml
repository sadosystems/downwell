if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    circle += wobblyAdd;
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            movesp = -1;
            image_index = 0;
            hitStun = 1;
            alarm[1] = 5;
        }
        
        playerDir = 90;
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
        
        finalDir = direction + lengthdir_x(wobblySize, circle);
        xsp = lengthdir_x(movesp, finalDir);
        ysp = lengthdir_y(movesp, finalDir);
        
        if (xx > (room_width - 160))
        {
            if (xsp > 0)
                xsp = 0;
        }
        else if (xx < 160)
        {
            if (xsp < 0)
                xsp = 0;
        }
        
        xscalePlx();
        xx += xsp;
        yy += ysp;
    }
    
    x = round(xx);
    y = round(yy);
}
else
{
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
    audio_play_sound(sndPlip, 0, 0);
    instance_destroy();
}

if (hitStun)
    sprite_index = sprSkullSoulDmg;
else
    sprite_index = sprEnmMoya;
