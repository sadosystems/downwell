function scrRechargeGem()
{
    if (global.stammo < global.ammo)
    {
        global.stammo += round(getAmount / 2);
        
        if (global.stammo > global.ammo)
            global.stammo = global.ammo;
        
        scrEffectSpawn(global.plx, global.ply, 111, 1, 0, -50500);
        soundPlay(27, 90, 0, 1);
        scrSShake(1, 2);
    }
}
