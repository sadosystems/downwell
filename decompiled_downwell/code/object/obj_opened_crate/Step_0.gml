if (flashing)
    dFlash *= -1;

if (!global.pTimeStop)
{
    ysp += ugrav;
    
    if (ysp > maxsp)
        ysp = maxsp;
    
    scrCheckCollisionWith(56);
    
    if (ycollision == 1)
        ysp = 0;
    
    yy += ysp;
}

y = round(yy);

if (lightFlashing)
{
    image_speed = 0.8;
}
else
{
    image_speed = 0;
    image_index = 0;
}
