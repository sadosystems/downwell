function spawnerSet3()
{
    enemyMaxCount = 16;
    
    if (global.level == 1)
    {
        enemyMaxCount = 8;
        chan = 0;
        spChannel[chan][0] = 320;
        spChannel[chan][1] = 260;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 160;
        spEnemy[chan][1] = 159;
        spEnemy[chan][2] = 123;
        spEnemy[chan][3] = 159;
        enemyMax[chan] = 3;
        chan = 1;
        spChannel[chan][0] = 1000;
        spChannel[chan][1] = 480;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 1;
        spEnemy[chan][0] = 158;
        enemyMax[chan] = 0;
        chan = 2;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 64;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 3;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 379;
        enemyMax[chan] = 0;
        chanMax = 2;
    }
    else if (global.level == 2)
    {
        enemyMaxCount = 8;
        chan = 0;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 240;
        spChannel[chan][2] = 40;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 160;
        spEnemy[chan][1] = 159;
        spEnemy[chan][2] = 123;
        spEnemy[chan][3] = 159;
        enemyMax[chan] = 3;
        chan = 1;
        spChannel[chan][0] = 1000;
        spChannel[chan][1] = 460;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 1;
        spEnemy[chan][0] = 158;
        spEnemy[chan][1] = 158;
        enemyMax[chan] = 1;
        chan = 2;
        spChannel[chan][0] = 320;
        spChannel[chan][1] = 240;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 0;
        spChannel[chan][4] = 0;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 160;
        enemyMax[chan] = 0;
        chan = 3;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 64;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 3;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 379;
        enemyMax[chan] = 0;
        chanMax = 3;
    }
    else if (global.level == 3)
    {
        enemyMaxCount = 8;
        chan = 0;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 240;
        spChannel[chan][2] = 100;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 160;
        spEnemy[chan][1] = 159;
        spEnemy[chan][2] = 123;
        spEnemy[chan][3] = 122;
        enemyMax[chan] = 3;
        chan = 1;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 360;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 1;
        spEnemy[chan][0] = 158;
        enemyMax[chan] = 0;
        chan = 2;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 64;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 3;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 379;
        enemyMax[chan] = 0;
        chanMax = 2;
    }
}
