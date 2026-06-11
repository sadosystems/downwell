if (imgSp == -1)
    imgSp = image_speed;

if (TimeStopBound())
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    xx += xsp;
    yy += ysp;
}
else if (image_speed != 0)
{
    image_speed = 0;
}

roundPosition();
