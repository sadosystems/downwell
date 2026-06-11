function hardSet1()
{
    enemyMaxCount = 20;
    
    if (global.level == 1)
    {
        chan = 0;
        spChannel[chan][0] = 160;
        spChannel[chan][1] = 240;
        spChannel[chan][2] = 64;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 115;
        spEnemy[chan][1] = 116;
        spEnemy[chan][2] = 114;
        spEnemy[chan][3] = 118;
        enemyMax[chan] = 3;
        chan = 1;
        spChannel[chan][0] = 160;
        spChannel[chan][1] = 360;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 1;
        spEnemy[chan][0] = 173;
        enemyMax[chan] = 0;
        chanMax = 1;
    }
    else if (global.level == 2)
    {
        chan = 0;
        spChannel[chan][0] = 160;
        spChannel[chan][1] = 300;
        spChannel[chan][2] = 100;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 1;
        spEnemy[chan][0] = 173;
        enemyMax[chan] = 0;
        chan = 1;
        spChannel[chan][0] = 160;
        spChannel[chan][1] = 220;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 2;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 118;
        spEnemy[chan][1] = 116;
        spEnemy[chan][2] = 114;
        spEnemy[chan][3] = 115;
        enemyMax[chan] = 3;
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
        spChannel[chan][5] = 1;
        spEnemy[chan][0] = 173;
        spEnemy[chan][1] = 173;
        enemyMax[chan] = 1;
        chan = 1;
        spChannel[chan][0] = 800;
        spChannel[chan][1] = 200;
        spChannel[chan][2] = 32;
        spChannel[chan][3] = 1;
        spChannel[chan][4] = 1;
        spChannel[chan][5] = 0;
        spEnemy[chan][0] = 118;
        spEnemy[chan][1] = 116;
        spEnemy[chan][2] = 114;
        enemyMax[chan] = 2;
        chanMax = 1;
    }
}
