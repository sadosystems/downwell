if (camPointy != other.y)
{
    camPointy = other.y;
    
    if (!sideLocked)
    {
        yy = other.y;
        y = other.y;
        sideLocked = 1;
    }
}

global.easter = 0;
global.achNoSideroom = 0;
