if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            movesp = -0.8;
            soundPlayOL(128, 50, 0, 1, "enemymove");
            image_index = 0;
            ascent = 0;
            hitStun = 1;
            alarm[1] = 8;
        }
        
        if (avenge == 1)
        {
            movesp = 1;
            maxsp = 2;
            acclamt = 0.05;
            dcclamt = 0.001;
            avenge = 2;
            ehp = 50;
            
            repeat (4)
                emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
            
            for (i = 0; i <= 1; i += 1)
            {
                if (myBaby[i][1])
                {
                    if (!myBaby[i][0].avenge)
                        myBaby[i][0].avenge = 1;
                }
            }
        }
        
        if (ascent == 1)
        {
            ysp = -2.25;
            randLock = global.ply + randAscent;
            
            if (yy < randLock)
                ascent = 2;
        }
        else if (ascent == 2)
        {
            ysp += 0.175;
            
            if (yy > randLock)
            {
                ascent = 0;
                idleSpr = 192;
                emitSmoke(x + 8, y, 0, 4);
                emitSmoke(x - 8, y, 180, 4);
                soundPlayOL(129, 50, 0, 1, "enemymove");
            }
        }
        
        if (!ascent)
        {
            if (idleSpr != 192)
                idleSpr = 192;
            
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
    scrDeadBody(deadSpr, takenImpact, 102);
    soundPlayOL(127, 50, 0, 1, "enemymove");
    
    for (i = 0; i <= 1; i += 1)
    {
        if (myBaby[i][1])
        {
            myBaby[i][0].avenge = 1;
            myBaby[i][0].mother = 0;
        }
    }
    
    instance_destroy();
}

if (hitStun)
    sprite_index = dmgSpr;
else if (!avenge)
    sprite_index = idleSpr;
else
    sprite_index = sprObakeAngry;

mask_index = sprite_index;
