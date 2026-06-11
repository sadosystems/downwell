if (!global.pTimeStop)
{
    if (ysp < -1)
        ysp += ugravhard;
    else
        ysp += ugrav;
    
    if (image_speed != imgSp)
        image_speed = imgSp;
}
else
{
    if (image_speed != 0)
        image_speed = 0;
    
    for (i = 0; i <= 1; i += 1)
    {
        if (alarm[i] > 0)
            alarm[i] += 1;
    }
}

if (place_meeting(xx + xsp, yy, sParentSolid))
{
    xsp *= -1;
    xsp *= 0.7;
}

if (place_meeting(xx, yy + ysp, sParentSolid))
{
    if (ysp <= 0)
        ysp *= 0;
    else
        ysp = irandom_range(-0.5, -0.8);
    
    xsp *= 0.7;
    image_speed = choose(-0.3, -0.1, 0, 0.1, 0.3);
}

if (abs(xsp) < 0.05)
    xsp = sign(xsp) * 0.05;

xx += xsp;
yy += ysp;
xsp *= 0.9;
ysp *= 0.9;

if (abs(xsp) < 0.05)
    xsp = 0;

if (abs(ysp) < 0.05)
    ysp = 0;

chkrange = 8;

if (place_meeting(xx, yy, sParentSolid))
{
    if (!place_meeting(xx + chkrange, yy, sParentSolid))
        xx += chkrange;
    else if (!place_meeting(xx - chkrange, yy, sParentSolid))
        xx -= chkrange;
    
    if (!place_meeting(xx, yy - chkrange, sParentSolid))
        yy -= chkrange;
    else if (!place_meeting(xx, yy + chkrange, sParentSolid))
        yy += chkrange;
    
    if (place_meeting(xx, yy, sParentSolid))
        instance_destroy();
}

if (dissapearing)
    dflash *= -1;
else
    dflash = -1;

if (instance_number(fxTimeShard) > shardLimit)
    instance_destroy();

if (outOfView(0, 320))
    instance_destroy();

x = round(xx);
y = round(yy);
