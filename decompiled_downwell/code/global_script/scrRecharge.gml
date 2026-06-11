function scrRecharge()
{
    if (global.stammo < global.ammo)
    {
        global.stammo = global.ammo;
        
        if (global.stammo > global.ammo)
            global.stammo = global.ammo;
        
        scrEffectSpawn(global.plx, global.ply, 111, 1, 0, -50500);
        myFx.image_xscale = 0.75;
        myFx.image_yscale = 0.75;
        soundPlay(27, 90, 0, 1);
        scrSShake(1, 2);
        
        with (objControlerN)
            meterJiggle = 4;
    }
    
    with (objPlayer_n)
        jetFrame = 0;
}
