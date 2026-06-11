if (mom)
{
    son = instance_create(x, y, gasSpin);
    son.mom = 0;
    son.circleMove = circleMove + 3;
    son.circleSpd = circleSpd;
    son.circleSize = circleSize;
    son.ascendSpeed = ascendSpeed;
    mom = 0;
}

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
            spRand = -random_range(0.1, 0.2);
            spRandx = (spRand / random_range(2, 5)) * choose(-1, 1);
            spRandy = spRand - abs(spRandx);
            posRand = random_range(-2, 2);
            fPart[i][0] = x + posRand;
            fPart[i][1] = y + posRand;
            fPart[i][3] = spRandx;
            fPart[i][4] = -spRandy;
            fPart[i][5] = random_range(0.3, 0.4);
        }
        else
        {
            fPart[i][2] = rSize + 1;
        }
    }
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            soundPlayOL(157, 50, 0, 1, "enemymove");
            image_index = 0;
            hitStun = 1;
            alarm[1] = 5;
        }
        
        if (!hitStun)
            circleMove += circleSpd;
        
        xx = xxx + (sin(circleMove) * circleSize);
        yy = yyy + (cos(circleMove) * circleSize);
    }
    
    if (hitStun)
        sprite_index = sprGasSphereHit;
    else
        sprite_index = sprDescentSphere;
    
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
