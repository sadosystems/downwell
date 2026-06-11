if (!allSet)
{
    xsp = lengthdir_x(ebSpeed, ebDir);
    ysp = lengthdir_y(ebSpeed, ebDir);
    
    if (imageAngled)
        image_angle = ebDir;
    
    allSet = 1;
}

if (!global.pTimeStop)
{
    if (decelerate)
        ebSpeed *= declSp;
    
    xsp = lengthdir_x(ebSpeed, ebDir);
    ysp = lengthdir_y(ebSpeed, ebDir);
    
    if (ebSpeed < 1)
    {
        if (!animation)
        {
            animation = 1;
            image_speed = 0.5;
        }
    }
    
    xx += xsp;
    yy += ysp;
    
    if (ebSpeed < maxsp)
        ebSpeed += accl;
    
    if (ebSpeed > maxsp)
        ebSpeed = maxsp;
}

x = round(xx);
y = round(yy);

if (!scrInView(0, -160, 160))
    instance_destroy();
