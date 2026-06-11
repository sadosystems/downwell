if (TimeStopBound())
{
    floatyCircle += floatySpeed;
    
    if (floatyCircle > 360)
        floatyCircle -= 360;
    
    floaty = lengthdir_y(floatyRange, floatyCircle);
    image_angle = floaty * 2;
    xx = xstart;
    yy = ystart + floaty;
    x = round(xx);
    y = round(yy);
}
