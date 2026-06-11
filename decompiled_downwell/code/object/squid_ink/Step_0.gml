if (TimeStopBound())
{
    image_speed = imgSp;
    
    if (!allSet)
    {
        allSet = 1;
        xsp = lengthdir_x(movesp, direction);
        ysp = lengthdir_y(movesp, direction);
        image_index = 0;
    }
    
    xsp = lengthdir_x(movesp, direction);
    ysp = lengthdir_y(movesp, direction);
    xx += xsp;
    yy += ysp;
    roundPosition();
    movesp *= 0.95;
}
else
{
    image_speed = 0;
}
