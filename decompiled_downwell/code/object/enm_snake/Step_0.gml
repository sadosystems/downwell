if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    ysp += global.grav;
    
    if (ysp >= global.maxgrav)
        ysp = global.maxgrav;
    
    if (grounded)
        active = 0;
    
    if (!active && grounded)
    {
        if (!place_meeting(xx + (sign(xsp) * 8), yy + 1, sParentSolid))
            xsp *= -1;
    }
    
    if (place_meeting(xx + xsp, yy, sParentSolid))
    {
        while (!place_meeting(xx + sign(xsp), yy, sParentSolid))
            xx += sign(xsp);
        
        xsp *= -1;
    }
    
    if (place_meeting(xx, yy, parentWater))
        inWater = 1;
    else
        inWater = 0;
    
    if (place_meeting(xx, yy + ysp, sParentSolid))
    {
        if (ysp > 0)
        {
            if (place_meeting(xx, yy + 1, sParentSolid))
            {
                ysp = 0;
                grounded = 1;
            }
            else
            {
                coldis = 0;
                
                for (i = 1; !place_meeting(xx, yy + i, sParentSolid); i += 1)
                    coldis += 1;
                
                ysp = coldis;
            }
        }
    }
    else if (place_meeting(xx, yy + 1, sParentSolid))
    {
        grounded = 1;
    }
    else
    {
        grounded = 0;
    }
    
    if (grounded)
        sprite_index = sprSnake;
    else
        sprite_index = sprSnakeAir;
    
    if (xsp != 0)
        image_xscale = sign(xsp);
    
    if (scrInView(0, 0, 32))
    {
        xx += xsp;
        yy += ysp;
        x = round(xx);
        y = round(yy);
    }
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
    scrBloodfx(0, 0);
    scrSmokefx(xx, yy, 1, 0);
    scrFlashballfx(xx, yy, 1, 0, 0);
    scrCurrencySpawn(money);
    scrDeadBody(165, takenImpact, 102);
    soundPlayOL(121, 50, 0, 1, "enemymove");
    instance_destroy();
}
