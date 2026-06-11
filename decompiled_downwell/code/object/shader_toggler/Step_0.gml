if (TimeStopBound())
{
    image_speed = imgSp;
    
    if (global.plx > xx)
        image_xscale = -1;
    else
        image_xscale = 1;
    
    if (!interactOk)
    {
        if (!place_meeting(xx, yy, objPlayer_n))
            interactOk = 1;
    }
    
    if (!speaking)
    {
        if (place_meeting(xx, yy, objPlayer_n) && global.interactable)
        {
            if (!speakDelay && global.dUp)
            {
                speaking = 1;
                global.noControl = 1;
                
                if (global.plx > xx)
                    objPlayer_n.image_xscale = -1;
                else
                    objPlayer_n.image_xscale = 1;
                
                textOver = 1;
                speakTimer = 0;
            }
        }
    }
    else if (speaking)
    {
        if (textOver == 1)
        {
            speaking = 0;
            textOver = 0;
            global.noControl = 0;
            interactOk = 0;
            interactOk = 1;
            scrShaderToggle();
        }
    }
    
    event_inherited();
}
else
{
    image_speed = 0;
}
