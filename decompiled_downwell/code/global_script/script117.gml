function script117()
{
    if (room == rmMenu)
    {
        i = 0;
        napSprite[i][0] = 11;
        napSprite[i][1] = 0.015;
        napSprite[i][2] = 112;
        napSprite[i][3] = 506;
        napSprite[i][4] = 1;
        i += 1;
        napSprite[i][0] = 12;
        napSprite[i][1] = 0.15;
        napSprite[i][2] = 112;
        napSprite[i][3] = 512;
        napSprite[i][4] = 1;
        i += 1;
        napSprite[i][0] = 14;
        napSprite[i][1] = 0;
        napSprite[i][2] = 290;
        napSprite[i][3] = 496;
        napSprite[i][4] = 1;
        i += 1;
        napSprite[i][0] = 13;
        napSprite[i][1] = 0;
        napSprite[i][2] = 80;
        napSprite[i][3] = 512;
        napSprite[i][4] = 1;
        napRand = irandom(i);
    }
}
