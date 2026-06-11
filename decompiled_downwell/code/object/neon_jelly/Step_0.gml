if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            direction = hitDir;
            movesp = 2;
            image_index = 0;
            soundPlayOL(118, 50, 0, 1, "enemymove");
        }
        
        if (!hitStun)
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
            
            if (direction > 180)
                maxsp = 0.8;
            else
                maxsp = 0.4;
            
            xsp = lengthdir_x(movesp, direction);
            ysp = lengthdir_y(movesp, direction);
            scrCheckCollisionWith(57);
            
            if (xcollision != 0)
                xsp = 0;
            
            if (ycollision != 0)
            {
                ysp = 0;
                
                if (ycollision == -1)
                    direction = 270;
            }
            
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
    scrEnemyDeath();
    scrSmokefx(x, y, 1, 0);
    
    repeat (4)
        emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
    
    scrFlashballfx(x, y, 1, 0, 0);
    scrCurrencySpawn(money);
    soundPlayOL(117, 50, 0, 1, "enemymove");
    instance_destroy();
}

if (hitStun)
    sprite_index = sprNeonJelly;
else
    sprite_index = sprNeonJelly;
