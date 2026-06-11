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
    xsp = lengthdir_x(ebSpeed, ebDir);
    ysp = lengthdir_y(ebSpeed, ebDir);
    xx += xsp;
    yy += ysp;
    
    if (ebSpeed < maxsp)
        ebSpeed += accl;
    
    if (ebSpeed > maxsp)
        ebSpeed = maxsp;
}

x = round(xx);
y = round(yy);

if (!scrInView(-32, -160, 160))
    instance_destroy();

if (global.bossDead)
    instance_destroy();
