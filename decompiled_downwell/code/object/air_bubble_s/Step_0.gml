if (TimeStopBound())
{
    image_speed = imgSp;
    ysp = -ascendsp;
    
    if (global.hardMode)
        ysp /= 3;
    
    if (place_meeting(xx + xsp, yy, parentWall))
    {
        xsp *= -1;
        xsp *= 0.2;
    }
    
    if (place_meeting(xx, yy + ysp, parentWall))
    {
        if (ysp <= 0)
            ysp = 0;
    }
    
    if (!place_meeting(x, y, parentWater))
        instance_destroy();
    
    if (dissapearing)
        dflash *= -1;
    else
        dflash = -1;
    
    if (abs(xsp) < 0.05)
        xsp = sign(xsp) * 0.05;
    
    if (attracted)
    {
        dir2p = point_direction(x, y, global.plx, global.ply);
        xsp = lengthdir_x(4, dir2p);
        ysp = lengthdir_y(4, dir2p);
    }
    
    xx += xsp;
    yy += ysp;
    xsp *= 0.97;
    ysp *= 0.9;
    x = round(xx);
    y = round(yy);
    
    if (abs(xsp) < 0.05)
        xsp = 0;
    
    if (abs(ysp) < 0.05)
        ysp = 0;
}
else
{
    image_speed = 0;
}

oxygen100 = global.oxygen / 100;

if (oxygen100 > 1)
    oxygen100 = 1;

if (oxygen100 < 0.5)
    oxygen100 = 0.5;

if (obtainable)
{
    if (collision_circle(xx, yy, 16 * oxygen100, objPlayer_n, 0, 0))
    {
        gainOxygen(10);
        emitMovingFx(x, y, 548, 0.2, 0, 0);
        soundPlayOL(308, 85, 0, 1, "waterThings");
        
        with (objPlayer_n)
        {
            if (global.oxygen > 40)
                alarm[8] = breathTimer;
            else if (global.oxygen > 20)
                alarm[8] = breathTimer / 2;
            else
                alarm[8] = breathTimer / 3;
        }
        
        instance_destroy();
    }
}
