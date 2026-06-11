function scrDmgCalcFxPlayer(arg0, arg1)
{
    with (instance_create(global.plx, global.ply - 4, objDmgCalcFxPlayer))
    {
        dmgamt = arg0;
        enemydir = arg1;
    }
}
