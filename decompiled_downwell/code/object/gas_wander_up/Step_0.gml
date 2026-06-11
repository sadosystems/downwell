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
        maxsp = origMaxsp;
        
        if (hit)
        {
            hit = 0;
            image_index = 0;
            hitStun = 1;
            alarm[1] = 5;
            
            if (stomped)
                alive = 0;
        }
        
        if (movesp < maxsp)
            movesp += acclamt;
        
        if (movesp > maxsp)
            movesp -= dcclamt;
        
        direction += rotAmt;
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
            
            xsp = lengthdir_x(movesp, direction);
            ysp = lengthdir_y(movesp, direction);
        }
        
        if (scrInView(0, -32, 32))
        {
            xx += xsp;
            yy += ysp;
        }
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
    if (active)
    {
        active = 0;
        scrEnemyDeath();
        
        repeat (4)
            emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
        
        scrFlashballfx(x, y, 1, 0, 0);
        scrCurrencySpawn(money);
        soundPlayOL(121, 50, 0, 1, "enemymove");
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
