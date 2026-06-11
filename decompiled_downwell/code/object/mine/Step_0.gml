if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (active)
    {
        if (hit)
        {
            hit = 0;
            direction = hitAngle;
            movesp = 1.5;
            image_index = 0;
            soundPlayOL(118, 50, 0, 1, "enemymove");
            hitStun = 1;
            alarm[1] = 5;
        }
        
        movesp *= 0.95;
        
        if (abs(movesp) < 0.2)
            movesp = 0;
        
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
    
    x = round(xx);
    y = round(yy);
}
else
{
    image_speed = 0;
}

if (ehp <= 0)
    alive = 0;

if (!alive && !hitStun)
{
    scrEnemyDeath();
    scrSmokefx(x, y, 1, 0);
    
    repeat (4)
        emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
    
    scrFlashballfx(x, y, 1, 0, 0);
    scrCurrencySpawn(money);
    soundPlayOL(117, 50, 0, 1, "enemymove");
    instance_create(x, y, bulletExplosion1);
    
    for (i = 0; i <= 3; i += 1)
    {
        myBul = instance_create(x, y, enmbul1);
        myBul.sprite_index = sprMineBullet;
        myBul.ebDir = 90 * i;
        myBul.imageAngled = 1;
        myBul.ebSpeed = 1.5;
    }
    
    instance_destroy();
}

if (hitStun)
    image_index = 1;
else
    image_index = 0;
