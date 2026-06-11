if (!roomDestSet)
{
    achievement_login();
    roomDest = 20;
    r[0] = 1;
    r[1] = 1;
    r[2] = 1;
    r[3] = 1;
    r[4] = 1;
    rTotal = 0;
    
    for (i = 0; i <= 4; i += 1)
        rTotal += r[i];
    
    rRand = 0;
    
    if (rRand < r[0])
        roomDest = 20;
    else if (rRand < (r[0] + r[1]))
        roomDest = 21;
    else if (rRand < (r[0] + r[1] + r[2]))
        roomDest = 22;
    else if (rRand < (r[0] + r[1] + r[2] + r[3]))
        roomDest = 23;
    else if (rRand < (r[0] + r[1] + r[2] + r[3] + r[4]))
        roomDest = 24;
    
    roomDestSet = 1;
    
    if (global.showSplash)
        alarm[0] = 10;
    else
        room_goto(roomDest);
}

if (global.showSplash)
{
    if (global.dUp)
    {
        global.showSplash += 1;
        alarm[0] = 60;
    }
    
    if (global.showSplash >= 7)
    {
        global.showSplash = 0;
        room_goto(roomDest);
    }
}
