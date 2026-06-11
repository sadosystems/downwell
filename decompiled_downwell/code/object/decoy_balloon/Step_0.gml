if (held)
{
    if (!global.ballooning)
        global.ballooning = 1;
    
    if (global.spinJumping)
        stringLength = 10;
    else
        stringLength = 20;
    
    pointy = global.ply;
    pointx = global.plx;
    
    while (true)
    {
        if (!collision_point(pointx, pointy - 4, parentWall, 0, 0))
            pointy -= 1;
        else
            break;
        
        if (pointy < (global.ply - stringLength))
            break;
    }
    
    pointy += (abs(pointx - xx) / 2);
    xMove = (pointx - xx) / (stringLength / 2);
    xx += xMove;
    
    if (yy < (global.ply - stringLength))
        yy += ((pointy - yy) / 4);
    else
        yy += ((pointy - yy) / 10);
    
    if (abs(xMove) > 0.2)
    {
        if (sprite_index != sprHeartBalloonPull)
            sprite_index = sprHeartBalloonPull;
        
        if (image_speed != 0)
            image_speed = 0;
        
        if (xMove > 0)
        {
            if (xMove > 1.2)
            {
                if (image_index != 1)
                    image_index = 1;
            }
            else if (image_index != 0)
            {
                image_index = 0;
            }
        }
        else if (xMove < 0)
        {
            if (xMove < -1.2)
            {
                if (image_index != 3)
                    image_index = 3;
            }
            else if (image_index != 2)
            {
                image_index = 2;
            }
        }
    }
    else
    {
        if (sprite_index != sprHeartBalloon)
            sprite_index = sprHeartBalloon;
        
        if (image_speed != imgSp)
            image_speed = imgSp;
    }
}

if (!held)
{
    if (collision_line(x, y, x, y + stringLength + 4, objPlayer_n, 0, 0) && !noHold)
    {
        held = 1;
        global.ballooning = id;
    }
    
    if (!place_meeting(xx, yy + ysp, parentWall))
    {
        maxAscSp = -0.8;
        
        if (ysp > maxAscSp)
            ysp -= 0.02;
        else
            ysp = maxAscSp;
    }
    else
    {
        ysp = 0;
    }
    
    xx += xsp;
    yy += ysp;
}

x = round(xx);
y = round(yy);
