function gainOxygen(arg0)
{
    global.oxygen += arg0;
    
    if (global.oxygen > 100)
        global.oxygen = 100;
    
    with (objPlayer_n)
    {
        alarm[9] = 30;
        alarm[8] = 5;
        oxyGetStun = 7;
    }
}
