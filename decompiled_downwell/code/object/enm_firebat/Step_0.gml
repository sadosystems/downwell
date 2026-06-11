if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    for (i = 0; i <= fPartAmt; i += 1)
    {
        if (fPart[i][2] < 8)
        {
            fPart[i][2] += fPart[i][5];
            fPart[i][0] += fPart[i][3];
            fPart[i][1] += fPart[i][4];
        }
        else if (active)
        {
            fPart[i][2] = 0;
            spRand = random_range(0.2, 0.5);
            spRandx = (spRand / random_range(2.5, 5)) * choose(-1, 1);
            spRandy = spRand - abs(spRandx);
            posRand = random_range(-2, 2);
            fPart[i][0] = x + posRand;
            fPart[i][1] = y + posRand;
            fPart[i][3] = spRandx;
            fPart[i][4] = -spRandy;
            fPart[i][5] = random_range(0.4, 0.6);
        }
    }
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            soundPlayOL(112, 50, 0, 1, "enemymove");
            direction = hitDir;
            movesp = 3;
            image_index = 0;
        }
        
        playerDir = point_direction(xx, yy, global.eplx, global.eply);
        playerDir += random_range(-20, 20);
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
        scrCheckCollisionWith(57);
        
        if (xcollision != 0 || ycollision != 0)
        {
            if (xcollision != 0)
                xsp = 0;
            
            if (ycollision != 0)
                ysp = 0;
        }
        
        xscaleXsp();
        xx += xsp;
        yy += ysp;
    }
    else if (!place_meeting(x, y - 16, parentWall) || global.ply > y)
    {
        active = 1;
        soundPlayOL(110, 50, 0, 1, "enemymove");
    }
    
    x = round(xx);
    y = round(yy);
}
else
{
    image_speed = 0;
}

if (active)
{
    sprite_index = sprBatRed;
}
else
{
    sprite_index = sprBatHang;
    direction = 270;
    movesp = 3;
}

if (ehp <= 0)
    alive = 0;

if (!alive)
{
    scrEnemyDeath();
    scrBloodfx(0, 0);
    scrSmokefx(x, y, 1, 0);
    scrFlashballfx(x, y, 1, 0, 0);
    scrCurrencySpawn(money);
    scrDeadBody(158, takenImpact, 102);
    soundPlayOL(111, 50, 0, 1, "enemymove");
    instance_destroy();
}
