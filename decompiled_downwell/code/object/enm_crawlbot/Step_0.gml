if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (!latched)
    {
        ysp += global.grav;
        movedir = 0;
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
    image_angle = movedir;
}
else
{
    image_speed = 0;
}

if (hit)
{
    hit = 0;
    image_index = 0;
    hitStun = 1;
    alarm[1] = 5;
}

if (hitStun)
    sprite_index = sprCrawlbotDmg;
else
    sprite_index = sprCrawlbot;

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
    audio_play_sound(sndPlip, 0, 0);
    instance_destroy();
}
