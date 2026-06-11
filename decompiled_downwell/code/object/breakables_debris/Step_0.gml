if (TimeStopBound())
{
    image_speed = imgSp;
    
    if (ysp < -1)
        ysp += ugravhard;
    else
        ysp += ugrav;
    
    if (place_meeting(x + xsp, y, sParentSolid))
    {
        xsp *= -1;
        xsp *= 0.7;
    }
    
    if (place_meeting(x, y + ysp, sParentSolid))
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
    
    x += xsp;
    y += ysp;
    chkrange = 8;
    
    if (place_meeting(x, y, sParentSolid))
    {
        if (!place_meeting(x + chkrange, y, sParentSolid))
            x += chkrange;
        else if (!place_meeting(x - chkrange, y, sParentSolid))
            x -= chkrange;
        
        if (!place_meeting(x, y - chkrange, sParentSolid))
            y -= chkrange;
        else if (!place_meeting(x, y + chkrange, sParentSolid))
            y += chkrange;
        
        if (place_meeting(x, y, sParentSolid))
            instance_destroy();
    }
    
    if (dissapearing)
        dflash *= -1;
    else
        dflash = -1;
}
else
{
    alarmStop(2);
    image_speed = 0;
}
