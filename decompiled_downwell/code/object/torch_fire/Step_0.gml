if (TimeStopBound())
{
    if (scrInView(0, 0, 0))
    {
        for (i = 0; i <= fPartAmt; i += 1)
        {
            if (fPart[i][2] < 8)
            {
                fPart[i][2] += fPart[i][5];
                fPart[i][0] += fPart[i][3];
                fPart[i][1] += fPart[i][4];
            }
            else if (active)
            {
                fPart[i][2] = 0;
                spRand = random_range(0.2, 0.5);
                spRandx = (spRand / random_range(2.5, 5)) * choose(-1, 1);
                spRandy = spRand - abs(spRandx);
                posRand = random_range(-2, 2);
                fPart[i][0] = x + posRand;
                fPart[i][1] = y + posRand;
                fPart[i][3] = spRandx;
                fPart[i][4] = -spRandy;
                fPart[i][5] = random_range(0.2, 0.4);
            }
        }
    }
    
    scrOutofview();
    
    if (objHp <= 0 && active)
    {
        soundPlay(359, 50, 0, 1);
        active = 0;
        mask_index = noMask;
        emitMovingFx(x, y, 84, 0.5, 0 + random(20), 1);
        emitMovingFx(x, y, 84, 0.5, 180 - random(20), 1);
        scrCurrencySpawn(2);
        
        if (stomped)
            myGem.attracted = 1;
        
        for (i = 0; i <= fPartAmt; i += 1)
        {
            fPart[i][2] = 0;
            spRand = random_range(0.2, 0.5);
            spRandx = (spRand / random_range(2.5, 5)) * choose(-1, 1);
            spRandy = spRand - abs(spRandx);
            posRand = random_range(-4, 4);
            fPart[i][0] = x + posRand;
            fPart[i][1] = y + posRand;
            fPart[i][3] = spRandx;
            fPart[i][4] = -spRandy;
            fPart[i][5] = random_range(0.15, 0.3);
        }
    }
}
