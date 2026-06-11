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
            image_index = 0;
            hitStun = 1;
            alarm[1] = 5;
        }
        
        direction = 270;
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
    scrDeadBody(229, takenImpact, 102);
    audio_play_sound(sndPlip, 0, 0);
    instance_destroy();
}

if (hitStun)
    sprite_index = sprDskullDmg;
else if (ysp > 0)
    sprite_index = sprDskull;
else
    sprite_index = sprDskullUp;
