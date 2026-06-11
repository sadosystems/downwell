function gainCharge(arg0)
{
    global.currencyStreak += (arg0 * 2);
    
    with (objPlayer_n)
    {
        global.puDepletionRate = 0;
        alarm[8] = 60;
        
        if (global.currencyStreak >= 100)
            alarm[8] = 180;
    }
}
