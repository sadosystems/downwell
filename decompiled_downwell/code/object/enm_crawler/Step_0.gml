if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (!latched && scrInView(0, 0, 64))
    {
        ysp += global.grav;
        
        if (clockwise)
            movedir = 0;
        else
            movedir = 180;
        
        xsp = 0;
        scrCheckCollisionWith(57);
        
        if (ycollision == 1)
        {
            ysp = 0;
            latched = 1;
        }
        
        xx += xsp;
        yy += ysp;
    }
    
    x = round(xx);
    y = round(yy);
    
    if (clockwise)
        image_angle = movedir;
    else
        image_angle = movedir + 180;
}
else
{
    image_speed = 0;
    alarmStop(1);
}

if (hit)
{
    hit = 0;
    image_index = 0;
    hitStun = 1;
    alarm[1] = 5;
}

if (hitStun)
    sprite_index = sprCrawlerDmg;
else
    sprite_index = sprCrawler;

if (ehp <= 0)
    alive = 0;

if (!alive)
{
    scrEnemyDeath();
    scrBloodfx(0, 0);
    scrSmokefx(xx, yy, 1, 0);
    scrFlashballfx(xx, yy, 1, 0, 0);
    scrCurrencySpawn(money);
    scrDeadBody(281, takenImpact, 102);
    soundPlayOL(124, 50, 0, 1, "enemymove");
    instance_destroy();
}
