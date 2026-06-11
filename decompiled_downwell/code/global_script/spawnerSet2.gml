function spawnerSet2()
{
    enemyMaxCount = 20;
    
    if (global.level == 1)
    {
        chan = 0;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 240;
        spChannel[chan][2] = 120;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 121;
        enemyMax[chan] = 0;
        chan = 1;
        spChannel[chan][0] = 1000;
        spChannel[chan][1] = 400;
        spChannel[chan][2] = 80;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 123;
        spEnemy[chan][1] = 116;
        enemyMax[chan] = 1;
        chan = 2;
        spChannel[chan][0] = 2000;
        spChannel[chan][1] = 1200;
        spChannel[chan][2] = 300;
        spChannel[chan][3] = 0;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 121;
        enemyMax[chan] = 0;
        chanMax = 2;
    }
    else if (global.level == 2)
    {
        chan = 0;
        spChannel[chan][0] = 1500;
        spChannel[chan][1] = 320;
        spChannel[chan][2] = 100;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 124;
        spEnemy[chan][1] = 121;
        spEnemy[chan][2] = 121;
        spEnemy[chan][3] = 121;
        enemyMax[chan] = 3;
        chan = 1;
        spChannel[chan][0] = 600;
        spChannel[chan][1] = 400;
        spChannel[chan][2] = 80;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 121;
        spEnemy[chan][1] = 123;
        spEnemy[chan][2] = 123;
        enemyMax[chan] = 2;
        chanMax = 1;
    }
    else if (global.level == 3)
    {
        chan = 0;
        spChannel[chan][0] = 1000;
        spChannel[chan][1] = 640;
        spChannel[chan][2] = 120;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 124;
        enemyMax[chan] = 0;
        chan = 1;
        spChannel[chan][0] = 600;
        spChannel[chan][1] = 400;
        spChannel[chan][2] = 80;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 123;
        enemyMax[chan] = 0;
        chan = 2;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 1200;
        spChannel[chan][2] = 300;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 121;
        enemyMax[chan] = 0;
        chanMax = 2;
    }
}
