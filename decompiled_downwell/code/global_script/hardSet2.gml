function hardSet2()
{
    enemyMaxCount = 20;
    
    if (global.level == 1)
    {
        chan = 0;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 480;
        spChannel[chan][2] = 80;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 116;
        spEnemy[chan][1] = 121;
        enemyMax[chan] = 1;
        chan = 1;
        spChannel[chan][0] = 600;
        spChannel[chan][1] = 320;
        spChannel[chan][2] = 48;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 123;
        enemyMax[chan] = 0;
        chan = 2;
        spChannel[chan][0] = 1600;
        spChannel[chan][1] = 600;
        spChannel[chan][2] = 120;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 121;
        enemyMax[chan] = 0;
        chanMax = 2;
    }
    else if (global.level == 2)
    {
        chan = 0;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 480;
        spChannel[chan][2] = 80;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 124;
        spEnemy[chan][1] = 121;
        enemyMax[chan] = 1;
        chan = 1;
        spChannel[chan][0] = 600;
        spChannel[chan][1] = 320;
        spChannel[chan][2] = 48;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 122;
        spEnemy[chan][1] = 123;
        enemyMax[chan] = 1;
        chan = 2;
        spChannel[chan][0] = 1600;
        spChannel[chan][1] = 600;
        spChannel[chan][2] = 120;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 121;
        enemyMax[chan] = 0;
        chanMax = 2;
    }
    else if (global.level == 3)
    {
        chan = 0;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 320;
        spChannel[chan][2] = 80;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 124;
        spEnemy[chan][1] = 121;
        enemyMax[chan] = 1;
        chan = 1;
        spChannel[chan][0] = 600;
        spChannel[chan][1] = 320;
        spChannel[chan][2] = 48;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 122;
        spEnemy[chan][1] = 123;
        enemyMax[chan] = 1;
        chan = 2;
        spChannel[chan][0] = 1600;
        spChannel[chan][1] = 600;
        spChannel[chan][2] = 120;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 121;
        enemyMax[chan] = 0;
        chanMax = 2;
    }
}
