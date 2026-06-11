function scrCheckThisSignStep()
{
    if (place_meeting(xx, yy, objPlayer_n) && global.interactable)
    {
        if (checkThis < 2)
            checkThis = 2;
        
        if (checkThis <= 5.1)
            checkThis += 0.3;
    }
    else
    {
        checkThis += 0.1;
        
        if (checkThis > 2)
            checkThis -= 2;
    }
}
