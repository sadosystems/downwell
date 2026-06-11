if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (active)
    {
        maxsp = origMaxsp;
        movesp -= 0.01;
        
        if (movesp <= 0.2)
            movesp = maxsp;
        
        if (hit)
        {
            hit = 0;
            direction = hitDir + (45 * sign(x - global.plx));
            image_index = 0;
            movesp = 1;
            hitStun = 1;
            alarm[1] = 5;
        }
        
        if (y > global.ply)
        {
            direction += rotAmt;
        }
        else
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
        }
        
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
        
        xscaleXsp();
        
        if (scrInView(0, -32, 32))
        {
            if (global.ply > y)
            {
                xx += xsp;
                yy += ysp;
            }
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
        instance_destroy();
        mask_index = noMask;
    }
}
