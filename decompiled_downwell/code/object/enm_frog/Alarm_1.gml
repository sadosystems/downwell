if (grounded && scrInView(0, 0, 0))
{
    prepare = 1;
    soundPlayOL(113, 50, 0, 1, "enemymove");
    
    if (global.plx > x)
    {
        xsp = 1;
        nsp = 2;
    }
    else
    {
        xsp = -1;
        nsp = -2;
    }
    
    alarm[0] = 60;
}
else
{
    alarm[1] = 60;
}
