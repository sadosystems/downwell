function scrLevelPat6()
{
    extraColumn = 1;
    levelLength = 140000;
    genCount = -10;
    bossItemSpawn = 0;
    rightRoomAmt = 0;
    rightRoomMade = 0;
    leftRoomAmt = 0;
    shopMade = 0;
    
    if (global.area == 1 && global.level == 1)
        shopMade = 1;
    
    scrStartPat6();
    scrEndPat6();
    scrLeftPat6();
    scrRightPat6();
    scrShopPat6();
    i = 0;
    partMain[i] = "\r\n\t.......BB\r\n\t.--....BB\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t..c......\r\n\t.---.....\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t...c.....\r\n\t..---....\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t...--....\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.-.......\r\n\t.......-.";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t-........\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.--......\r\n\t........1\r\n\t........1\r\n\t....c...1\r\n\tB...--..1\r\n\tB.......1\r\n\t.........\r\n\t..--.....\r\n\t.........";
    i += 1;
    partMain[i] = "\r\n\t.........\r\n\t.......Q.\r\n\t.--...111\r\n\t......111\r\n\t.......11\r\n\tB........\r\n\tBB.......\r\n\tBB...--..\r\n\tB........\r\n\t.........";
    partMain[100] = i;
    i = 0;
}
