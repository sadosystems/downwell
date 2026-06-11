if (global.pugKnifefork)
{
    if (active)
    {
        global.bodiesEaten += 1;
        soundPlay(83, 80, 0, 1);
        
        repeat (5)
            instance_create(global.plx, global.ply, fxBlood);
        
        instance_destroy();
    }
}

scrTypicalDamage(1, 3, 2);
