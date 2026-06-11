if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            movesp = 0;
            image_index = 0;
            hitStun = 1;
            alarm[1] = 5;
            imgSp = 0.4;
        }
        
        if (!angry)
        {
            if (movesp < maxsp)
                movesp += acclamt;
            
            direction += rotAmt;
            xsp = lengthdir_x(movesp, direction);
            ysp = lengthdir_y(movesp, direction);
        }
        else if (angry)
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
            
            xsp = lengthdir_x(movesp, direction);
            ysp = lengthdir_y(movesp, direction);
        }
        
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
    soundPlayOL(117, 50, 0, 1, "enemymove");
    instance_destroy();
}

if (hitStun)
    sprite_index = stunSpr;
else
    sprite_index = normalSpr;
