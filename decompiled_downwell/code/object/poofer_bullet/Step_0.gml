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
    xx += xsp;
    yy += ysp;
}

x = round(xx);
y = round(yy);

if (point_distance(xstart, ystart, x, y) > ebDist)
{
    xsp *= 0.9;
    ysp *= 0.9;
    image_speed = disappearSp;
}
