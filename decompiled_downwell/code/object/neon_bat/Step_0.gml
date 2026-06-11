if (!allSet)
{
    hang = 0;
    active = 1;
    allSet = 1;
}

if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (hit)
    {
        hit = 0;
        hitStun = 1;
        alarm[0] = 3;
        soundPlayOL(112, 50, 0, 1, "enemymove");
        direction = hitDir;
        movesp = 3;
        image_index = 0;
        active = 1;
    }
    
    if (active && !hitStun)
    {
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
    else
    {
        if (global.ply > (y - 4))
        {
            active = 1;
            soundPlayOL(110, 50, 0, 1, "enemymove");
        }
        
        if (hang == -10)
        {
            if (!place_meeting(x, y - 16, parentWall))
            {
                active = 1;
                soundPlayOL(110, 50, 0, 1, "enemymove");
            }
        }
        else if (hang)
        {
            if (!place_meeting(x + 16, y, parentWall))
            {
                active = 1;
                soundPlayOL(110, 50, 0, 1, "enemymove");
            }
        }
        else if (!place_meeting(x - 16, y, parentWall))
        {
            active = 1;
            soundPlayOL(110, 50, 0, 1, "enemymove");
        }
    }
    
    x = round(xx);
    y = round(yy);
}
else
{
    image_speed = 0;
}

if (active)
    sprite_index = sprNeonBat;

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
