if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (hit)
    {
        hit = 0;
        image_index = 0;
        hitStun = 1;
        alarm[0] = 5;
    }
    
    if (hitStun)
        sprite_index = stunSpr;
    else
        sprite_index = normalSpr;
    
    if (!hanging)
    {
        if (mask_index != sprSpiderIdle)
            mask_index = sprSpiderIdle;
        
        if (stunSpr != 238)
            stunSpr = 238;
        
        if (!grounded)
            walking = -1;
        
        if (grounded)
        {
            if (walking)
                normalSpr = 239;
            else
                normalSpr = 237;
            
            if (!landed)
                landed = 1;
        }
        else
        {
            normalSpr = 240;
        }
        
        ysp += global.grav;
        
        if (walking)
            xsp = walksp * walkdir;
        else
            xsp = 0;
        
        if (!place_meeting(x, y + 1, sParentSolid))
            grounded = 0;
        
        scrCheckCollisionWith(87);
        
        if (ycollision != 0)
        {
            if (ycollision == 1)
            {
                if (!place_meeting(xx, yy, parentThinwall))
                {
                    grounded = 1;
                    ysp = 0;
                }
            }
        }
        
        scrCheckCollisionWith(57);
        
        if (ycollision != 0)
        {
            if (ycollision == 1)
            {
                if (!place_meeting(xx, yy, parentThinwall))
                {
                    grounded = 1;
                    ysp = 0;
                }
            }
        }
        
        if (xcollision != 0)
        {
            walkdir *= -1;
            xsp = walksp * walkdir;
        }
        else if (grounded)
        {
            if (!collision_point(xx + (sign(xsp) * 4), yy + 9, sParentSolid, 0, 0))
            {
                walkdir *= -1;
                xsp = walksp * walkdir;
            }
        }
    }
    else if (hanging)
    {
        normalSpr = 240;
        
        if (collision_line(x, y, x, y + 160, objPlayer_n, 0, 0))
        {
            if (scrInView(0, 0, 0))
                hanging = 0;
        }
        
        if (y < (weby + webLength))
            ysp += boingAccl;
        else
            ysp -= boingAccl;
        
        if (place_meeting(x, y, parentWall))
        {
            if ((weby + webLength) > (ystart + 16))
                webLength -= 2;
        }
        
        if (!place_meeting(x, weby, sParentSolid))
            hanging = 0;
        
        if (abs(ysp) > maxsp)
            ysp = maxsp * sign(ysp);
    }
    
    xx += xsp;
    yy += ysp;
    x = round(xx);
    y = round(yy);
    xscaleXsp();
}
else
{
    image_speed = 0;
    alarmStop(0);
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
    scrDeadBody(deadSpr, takenImpact, 102);
    instance_destroy();
}

if ((y - weby) > 160)
    weby = y - 160;
