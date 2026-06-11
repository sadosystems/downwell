function scrEnemyDeath()
{
    global.comboCount += 1;
    gunshotStop();
    global.killCount += 1;
    global.achNoKill = 0;
    momentDelay();
    levelBeginCue();
}
