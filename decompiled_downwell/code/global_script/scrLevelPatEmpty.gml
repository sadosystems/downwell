function scrLevelPatEmpty()
{
    levelLength = 12;
    rightRoomAmt = choose(2, 3);
    rightRoomMade = 0;
    scrStartPat3_new();
    scrEndPat3_new();
    scrLeftPat3_new();
    scrRightPat3_new();
    scrShopPat3_new();
    i = 0;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t......C..\r\n\tA........\r\n\t1........\r\n\t1........\r\n\t1........\r\n\t1...C....\r\n\t1........\r\n\t1.......A\r\n\t........1\r\n\t........1\r\n\t.C......1\r\n\t........1\r\n\t........1\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t..C......\r\n\tA........\r\n\t1........\r\n\t1.....C..\r\n\t1........\r\n\t1........\r\n\t1........\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t......C..\r\n\t.........\r\n\tA........\r\n\t1........\r\n\t1........\r\n\t1.C......\r\n\t1.......A\r\n\t1.......1\r\n\t........1\r\n\t.....C..1\r\n\t.........";
    partMain[100] = i;
    i = 0;
}
