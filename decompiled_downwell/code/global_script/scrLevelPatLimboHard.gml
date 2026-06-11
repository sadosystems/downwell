function scrLevelPatLimboHard()
{
    levelLength = 16 + global.level;
    extraColumn = 7;
    
    if (global.level == 1)
        genCount = -34;
    else
        genCount = -10;
    
    rightRoomAmt = 1;
    rightRoomMade = 0;
    leftRoomAmt = 0;
    shopMade = 0;
    scrStartPatLimboHard();
    scrEndPatLimboHard();
    scrLeftPatLimboHard();
    scrRightPatLimboHard();
    scrShopPatLimboHard();
    i = 0;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........";
    partMain[100] = i;
    i = 0;
}
