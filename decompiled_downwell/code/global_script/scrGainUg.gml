function scrGainUg(arg0)
{
    t = arg0;
    
    if (global.ug[t][1] >= global.ug[t][4])
    {
        global.currency += 100;
    }
    else
    {
        global.ug[t][1] += 1;
        scrIncrementPug(t);
        
        if (t < 100)
        {
            global.ugHave += 1;
            global.ugOrder[global.ugHave] = arg0;
        }
    }
    
    if (t == 13)
        gainHp(4);
    
    if (t == 6)
        gainHp(1);
    
    if (t == 19)
    {
        global.ammo += 4;
        global.stammo = global.ammo;
    }
    
    if (t == 21)
    {
        global.currency += 400;
        global.gameGem += 400;
        soundPlay(167, 60, 0, 1);
    }
}
