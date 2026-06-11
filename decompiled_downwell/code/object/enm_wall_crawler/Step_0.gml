if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    image_angle = direction;
    
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
    
    xsp = lengthdir_x(movesp, direction);
    ysp = lengthdir_y(movesp, direction);
    
    if (collision_point(xx + (sign(xsp) * 9), yy + (sign(ysp) * 9), parentWall, 0, 0))
    {
        while (!collision_point(xx + (sign(xsp) * 9), yy + (sign(ysp) * 9), parentWall, 0, 0))
        {
            xx += sign(xsp);
            yy += sign(ysp);
        }
        
        direction += 90;
    }
    else
    {
        crawling = crawlCheck(xx + xsp, yy + ysp, 16);
        
        if (crawling)
        {
            xx += xsp;
            yy += ysp;
        }
        else
        {
            while (crawlCheck(xx + sign(xsp), yy + sign(ysp), 16))
            {
                xx += sign(xsp);
                yy += sign(ysp);
            }
            
            direction -= 90;
        }
    }
    
    roundPosition();
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
