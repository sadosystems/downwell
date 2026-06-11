if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (hit)
    {
        hit = 0;
        soundPlayOL(150, 50, 0, 1, "waterEnemy");
        image_index = 0;
        hitStun = 1;
        alarm[0] = 5;
    }
    
    if (hitStun)
        sprite_index = stunSpr;
    else
        sprite_index = normalSpr;
    
    if (ascending)
    {
        ysp *= 0.95;
        
        if (ysp > -0.4)
            imgSp = defImgSp;
        
        if (round(image_index) == 4)
        {
            if (!swimKick)
            {
                ysp = maxsp;
                swimKickSnd = soundPlayOL(151, 50, 0, 1, "waterThings");
                sndgain = 1 - (abs((__view_get(e__VW.YView, 0) + 160) - y) / 200);
                
                if (sndgain < 0)
                    sndgain = 0;
                
                audio_sound_gain(swimKickSnd, sndgain, 0);
                swimKick = 1;
                
                repeat (1)
                {
                    myBubble = instance_create(x, y, airBubbleMicro);
                    myBubble.xsp = random_range(-1.5, 1.5);
                    myBubble.ysp = random_range(2, 3);
                }
            }
        }
        else
        {
            swimKick = 0;
        }
        
        if (y < (__view_get(e__VW.YView, 0) - 8))
        {
            alarm[1] = 5;
            ascending = 0;
            image_yscale = -1;
            ysp = 0;
        }
    }
    else
    {
        if (ysp < 0)
            ysp *= 0.9;
        
        if (round(image_index) == 4)
        {
            if (!swimKick)
            {
                swimKickSnd = soundPlayOL(149, 50, 0, 1, "waterThings");
                sndgain = 1 - (abs((__view_get(e__VW.YView, 0) + 180) - y) / 300);
                
                if (sndgain < 0)
                    sndgain = 0;
                
                audio_sound_gain(swimKickSnd, sndgain, 0);
                swimKick = 1;
                
                repeat (1)
                {
                    myBubble = instance_create(x, y, airBubbleMicro);
                    myBubble.xsp = random_range(-1.5, 1.5);
                    myBubble.ysp = random_range(-4, -3);
                }
            }
        }
        else
        {
            swimKick = 0;
        }
        
        if (y > (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + 160))
            instance_destroy();
    }
    
    xx += xsp;
    yy += ysp;
    roundPosition();
}
else
{
    image_speed = 0;
    alarmStop(2);
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
    
    repeat (4)
        emitSquidInk(x, y + 16, 270 + random_range(-45, 45), random_range(0.2, 2));
    
    soundPlayOL(148, 50, 0, 1, "waterEnemy");
    instance_destroy();
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
