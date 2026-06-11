function groundRoom()
{
    grgrgr = false;
    
    switch (room)
    {
        case rmMenu:
        case rmGroundRuin:
        case rmGroundGrave:
        case rmGroundMeteor:
        case rmGroundDouble:
            grgrgr = true;
            break;
    }
    
    return grgrgr;
}
