function scrGravity_n()
{
    if (global.area == 4)
    {
        finalMaxgrav = 6;
        finalGrav = global.grav;
    }
    else if (global.gInWater)
    {
        finalMaxgrav = 6;
        finalGrav = global.grav / 1.4;
    }
    else if (global.playStyle == 3)
    {
        finalMaxgrav = global.maxgrav;
        finalGrav = global.grav / 1.5;
    }
    else
    {
        finalMaxgrav = global.maxgrav;
        finalGrav = global.grav;
    }
    
    if (global.ballooning)
        finalMaxgrav -= 1;
    
    ysp += finalGrav;
    
    if (ysp >= finalMaxgrav)
        ysp = finalMaxgrav;
}
