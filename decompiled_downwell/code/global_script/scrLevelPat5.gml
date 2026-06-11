function scrLevelPat5()
{
    extraColumn = 16;
    levelLength = 24;
    genCount = -10;
    rightRoomAmt = 1;
    rightRoomMade = 0;
    leftRoomAmt = 0;
    shopMade = 0;
    scrStartPat5();
    scrEndPat5();
    scrLeftPat5();
    scrRightPat5();
    scrShopPat5();
    i = 0;
    partMain[i] = "\r\n\t...........\r\n\t...........\r\n\t...........\r\n\t...........\r\n\t";
    i += 1;
    partMain[i] = "\r\n\t...........\r\n\t...........\r\n\t...........\r\n\t...........\r\n\t...........\r\n\t...........";
    partMain[100] = i;
    i = 0;
}
