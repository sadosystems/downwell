function scrTypicalDamage(arg0, arg1, arg2)
{
    pdmg = arg0;
    pximpact = arg1;
    pyimpact = arg2;
    
    if (!global.playerDamaged)
    {
        pdir = point_direction(x, y, global.plx, global.ply);
        scrPDamage(pdmg);
        scrFjump(lengthdir_x(pximpact, pdir), pyimpact);
        
        if (!global.death)
            scrSShake(5, 8);
        
        if (global.playerHp > 0)
            scrEffectSpawn(global.plx, global.ply, 114, 0.4, 0, -100000);
        
        if (global.pugTime)
        {
            with (objPlayer_n)
            {
                if (!global.pTimeStop)
                    instance_create(x, y, parentTimeField);
            }
        }
        
        global.achNoDamage = 0;
        global.achAreaNoDamage = 0;
    }
}
