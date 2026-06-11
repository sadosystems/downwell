if (endExplosion < 10)
{
    endExplosion += 1;
    
    repeat (5)
        instance_create(x, y, bulletExplosion1);
    
    repeat (5)
        instance_create(x, y + 64, bulletExplosion1);
    
    scrSmokefx(x, y, 1, 0);
    emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
    scrFlashballfx(x, y, 1, 0, 0);
    alarm[11] = choose(5, 10, 20, 30);
    
    if (endExplosion >= 9)
        alarm[11] = 50;
    
    if (endExplosion >= 10)
    {
        instance_create(x, y, boxFlash);
        soundPlayOL(205, 100, 0, 1, "boss");
        alarm[11] = 5;
    }
}
else if (endExplosion == 10)
{
    repeat (10)
        instance_create(x, y, bulletExplosion1);
    
    repeat (10)
        instance_create(x, y + 64, bulletExplosion1);
    
    scrSmokefx(x, y, 1, 0);
    emitMovingFx(xx, yy, 704, random_range(0.2, 0.3), random(359), random_range(1, 2));
    scrFlashballfx(x, y, 1, 0, 0);
    
    if (!global.death)
    {
        with (objControlerN)
            alarm[5] = 600;
        
        global.noShot = 1;
        
        with (objPlayer_n)
        {
            comboDone();
            global.spinJumping = 0;
            airborneShot = 0;
        }
    }
    
    scrPugReset();
    global.noShot = 1;
    scrRecharge();
    endExplosion += 1;
    alarm[11] = 40;
    
    if (global.isPC)
    {
        if (!global.hardMode)
        {
            steamAchGet(UnknownEnum.Value_11);
            steamConvertTimeSubmit();
        }
        else
        {
            steamAchGet(UnknownEnum.Value_21);
            steamConvertTimeSubmit();
        }
    }
    
    saveStats();
}
else if (endExplosion == 11)
{
    instance_destroy();
}

enum UnknownEnum
{
    Value_11 = 11,
    Value_21 = 21
}
