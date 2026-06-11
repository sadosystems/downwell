function spawnerSet5()
{
    enemyMaxCount = 20;
    
    if (global.level == 1)
    {
        chan = 0;
        spChannel[chan][0] = 100000000;
        spChannel[chan][1] = 1000000;
        spChannel[chan][2] = 0;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 108;
        enemyMax[chan] = 0;
        chan = 1;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 160;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 3;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 159;
        spEnemy[chan][1] = 159;
        enemyMax[chan] = 1;
        chan = 2;
        spChannel[chan][0] = 1000;
        spChannel[chan][1] = 240;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 1;
        spEnemy[chan][0] = 158;
        enemyMax[chan] = 0;
        chan = 3;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 1000000;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 1;
        spEnemy[chan][0] = 188;
        enemyMax[chan] = 0;
        chanMax = 0;
    }
    else if (global.level == 2)
    {
        chan = 0;
        spChannel[chan][0] = 160;
        spChannel[chan][1] = 160;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 115;
        enemyMax[chan] = 0;
        chan = 1;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 360;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 118;
        spEnemy[chan][1] = 116;
        enemyMax[chan] = 1;
        chanMax = 1;
    }
    else if (global.level == 3)
    {
        chan = 0;
        spChannel[chan][0] = 160;
        spChannel[chan][1] = 240;
        spChannel[chan][2] = 64;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 115;
        spEnemy[chan][1] = 116;
        enemyMax[chan] = 1;
        chan = 1;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 600;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 118;
        spEnemy[chan][1] = 116;
        spEnemy[chan][2] = 118;
        enemyMax[chan] = 2;
        chanMax = 1;
    }
}
