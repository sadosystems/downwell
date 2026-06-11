if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    for (i = 0; i <= fPartAmt; i += 1)
    {
        if (fPart[i][2] < rSize)
        {
            fPart[i][2] += fPart[i][5];
            fPart[i][0] += fPart[i][3];
            fPart[i][1] += fPart[i][4];
        }
        else if (active)
        {
            fPart[i][2] = 1;
            spRand = -random_range(0.5, 0.6);
            spRandx = (spRand / random_range(2, 5)) * choose(-1, 1);
            spRandy = spRand - abs(spRandx);
            posRand = random_range(-2, 2);
            fPart[i][0] = x + posRand;
            fPart[i][1] = y + posRand;
            fPart[i][3] = spRandx;
            fPart[i][4] = -spRandy;
            fPart[i][5] = random_range(0.5, 0.6);
        }
        else
        {
            fPart[i][2] = rSize + 1;
        }
    }
    
    if (active)
    {
        if (!global.death)
        {
            if (objPlayer_n.ysp > 0)
                maxsp = origMaxsp + (objPlayer_n.ysp / 1.5);
            else
                maxsp = origMaxsp;
        }
        else
        {
            maxsp = origMaxsp;
        }
        
        if (hit)
        {
            hit = 0;
            image_index = 0;
            hitStun = 1;
            alarm[1] = 5;
            soundPlayOL(157, 50, 0, 1, "enemymove");
            
            if (stomped)
                alive = 0;
        }
        
        playerDir = 270;
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
        
        direction = 270;
        xsp = lengthdir_x(movesp, direction);
        ysp = lengthdir_y(movesp, direction);
        
        if (xsp != 0)
            image_xscale = sign(xsp);
        
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

if (!hitStun)
    sprite_index = sprDescentDrill;
else
    sprite_index = sprGasDrillHit;

if (ehp <= 0)
    alive = 0;

if (!alive)
{
    if (active)
    {
        active = 0;
        scrEnemyDeath();
        
        repeat (4)
            emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
        
        scrFlashballfx(x, y, 1, 0, 0);
        scrCurrencySpawn(money);
        soundPlayOL(156, 50, 0, 1, "enemymove");
        mask_index = noMask;
        emitMovingFx(x, y, 118, 0.7, 0, 0);
    }
    
    dest = 1;
    
    for (i = 0; i <= fPartAmt; i += 1)
    {
        if (fPart[i][2] != (rSize + 1))
            dest += -1;
    }
    
    if (dest)
        instance_destroy();
}
