if (!global.pTimeStop)
{
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    ysp += ugrav;
    xx += xsp;
    yy += ysp;
    x = round(xx);
    y = round(yy);
    
    if (objHp <= 0 && active)
    {
        image_speed = 0;
        mask_index = noMask;
        xsp = 0;
        ysp = 0;
        active = 0;
        instance_destroy();
        scrFxNol(85, 0.3);
    }
}
else
{
    image_speed = 0;
}

if (!scrInView(0, 0, 0))
    instance_destroy();
