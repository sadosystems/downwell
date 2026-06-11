function scrLevelPat4()
{
    extraColumn = 4;
    levelLength = 5 + global.level;
    
    if (global.hardMode)
        levelLength = 4 + global.level;
    
    if (global.level == 1)
        genCount = -10;
    else
        genCount = -1;
    
    rightRoomAmt = choose(2);
    rightRoomMade = 0;
    leftRoomAmt = choose(0, 1, 1, 1);
    shopMade = 0;
    
    if (global.level == 1)
        scrStartPat4Splash();
    else
        scrStartPat4();
    
    scrEndPat4();
    scrAquiferFiller();
    scrRightPat4();
    scrShopPat4();
    i = 0;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\tA.......1\r\n\tA......11\r\n\tA.....A11\r\n\t......111\r\n\t....T.111\r\n\t...1111111\r\n\t....A1111\r\n\t.....A111\r\n\t........1";
    i += 1;
    partMain[i] = "\r\n\t1A.......\r\n\tA........\r\n\t........1\r\n\t.....T.11\r\n\t....11111\r\n\t....11111\r\n\t...A11111\r\n\t...111111\r\n\t...111111\r\n\t...111111\r\n\t...111111\r\n\t.....1111\r\n\t.....AA11\r\n\t.......A1\r\n\t...G....1\r\n\t.........\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\tA........\r\n\tA.......B\r\n\t......T.B\r\n\t....11111\r\n\t...111111\r\n\t.....1111\r\n\t.......11\r\n\t.......A1\r\n\tA......A1\r\n\tA......A1\r\n\tAAA.....A\r\n\t111......\r\n\t11..G....\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\tAAA......\r\n\t111...AAA\r\n\t111BB.111\r\n\t1..BB..11\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.T.......\r\n\t111......\r\n\t11....G..\r\n\t1........\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t.......AA\r\n\tBB...T.11\r\n\tBB.111111\r\n\t...111111\r\n\t.....1111\r\n\t..G.....1\r\n\t........A\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.....T...\r\n\t....111AA\r\n\t.....A111\r\n\t......111\r\n\t..G....11\r\n\t........1\r\n\t........1";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t......AAA\r\n\t..G...111\r\n\t.......1A\r\n\t........A\r\n\t........A\r\n\t.........\r\n\t.........\r\n\tBB.......\r\n\tBB....T..\r\n\t.....1111\r\n\t......111\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.......AA\r\n\t.......11\r\n\t.....G.11\r\n\t.......11\r\n\tG......11\r\n\t.......11\r\n\t.......11\r\n\t.........\r\n\tAA.......\r\n\t11....T..\r\n\t11BBB111.\r\n\tA.BBB111.\r\n\t.........\r\n\t.........\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t........1\r\n\tA......11\r\n\tA.....111\r\n\tA.....111\r\n\t.......11\r\n\t.......11\r\n\t.......11\r\n\t....T.111\r\n\t...111111\r\n\tBBB111111\r\n\tBB..11111\r\n\t......A11";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\tBB.......\r\n\tBBB...AAA\r\n\t......111\r\n\t......111\r\n\t.......11\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.AA......\r\n\t111.T....\r\n\t111111...\r\n\t11.......";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t.......T.\r\n\t......111\r\n\t......111\r\n\t......A11\r\n\tBBB....A1\r\n\tBB.....A1\r\n\t.........\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t......AAA\r\n\t......111\r\n\t.......11\r\n\t........A\r\n\t........A\r\n\tAA.......\r\n\t11BBBB...\r\n\t.........\r\n\t.........\r\n\t.........\r\n\t.......T.\r\n\t......111\r\n\t........1";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\t.......T.\r\n\t......111\r\n\t......A11\r\n\t.......AA\r\n\t........A\r\n\t........A\r\n\t.........\r\n\tAA.......\r\n\t11A......\r\n\t111...AAA\r\n\t11....111\r\n\t1.....111\r\n\t......111\r\n\t.......11\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t....BB...\r\n\t.........\r\n\tA........\r\n\tA........\r\n\t.......BB\r\n\t......BBB\r\n\t.......BB\r\n\t.........\r\n\t.........\r\n\t.T.......\r\n\t111......\r\n\t.........\r\n\t....BB...";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.........\r\n\tB.......A\r\n\tBB.......\r\n\tBBB.....A\r\n\t111.T....\r\n\t111111...\r\n\t11111....\r\n\t11.......\r\n\t1........";
    partMain[100] = i;
    i = 0;
}
