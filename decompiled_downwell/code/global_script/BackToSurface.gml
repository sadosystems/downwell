function BackToSurface()
{
    roomDest = 20;
    r[0] = 4;
    r[1] = 4;
    r[2] = 3;
    r[3] = 3;
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
    
    room_goto(roomDest);
}
