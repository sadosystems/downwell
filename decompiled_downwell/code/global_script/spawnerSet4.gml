function spawnerSet4()
{
    enemyMaxCount = 20;
    
    if (global.level == 1)
    {
        chan = 0;
        spChannel[chan][0] = 1200;
        spChannel[chan][1] = 200;
        spChannel[chan][2] = 16;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 129;
        enemyMax[chan] = 0;
        chan = 1;
        spChannel[chan][0] = 2500;
        spChannel[chan][1] = 160;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 132;
        spEnemy[chan][1] = 132;
        enemyMax[chan] = 1;
        chan = 2;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 48;
        spChannel[chan][2] = 16;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 3;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 381;
        enemyMax[chan] = 0;
        chan = 3;
        spChannel[chan][0] = 1000;
        spChannel[chan][1] = 240;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 130;
        spEnemy[chan][1] = 130;
        spEnemy[chan][2] = 130;
        enemyMax[chan] = 2;
        chanMax = 3;
    }
    else if (global.level == 2)
    {
        chan = 0;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 180;
        spChannel[chan][2] = 16;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 129;
        spEnemy[chan][1] = 129;
        enemyMax[chan] = 1;
        chan = 1;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 250;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 128;
        spEnemy[chan][1] = 132;
        spEnemy[chan][2] = 130;
        spEnemy[chan][3] = 130;
        enemyMax[chan] = 3;
        chan = 2;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 48;
        spChannel[chan][2] = 16;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 3;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 381;
        enemyMax[chan] = 0;
        chan = 3;
        spChannel[chan][0] = 1000;
        spChannel[chan][1] = 480;
        spChannel[chan][2] = 80;
        spChannel[chan][3] = 0;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 132;
        enemyMax[chan] = 0;
        chanMax = 3;
    }
    else if (global.level == 3)
    {
        chan = 0;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 180;
        spChannel[chan][2] = 16;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 129;
        spEnemy[chan][1] = 129;
        enemyMax[chan] = 1;
        chan = 1;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 200;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 128;
        spEnemy[chan][1] = 132;
        spEnemy[chan][2] = 128;
        spEnemy[chan][3] = 130;
        enemyMax[chan] = 3;
        chan = 2;
        spChannel[chan][0] = 0;
        spChannel[chan][1] = 48;
        spChannel[chan][2] = 16;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 3;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 381;
        enemyMax[chan] = 0;
        chan = 3;
        spChannel[chan][0] = 1500;
        spChannel[chan][1] = 600;
        spChannel[chan][2] = 80;
        spChannel[chan][3] = 2;
        spChannel[chan][4] = 4;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 132;
        enemyMax[chan] = 0;
        chanMax = 3;
    }
}
