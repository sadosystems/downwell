if (yy > global.ply)
{
    if (!objPlayer_n.grounded)
    {
        if (objPlayer_n.ysp > 0)
        {
            if (global.pugGravsuit)
                scrFjump(0, 0.1);
            else
                scrFjump(0, 2.5);
            
            levelBeginCue();
            scrSShake(2, 10);
            scrEffectSpawn(x, y, 605, 0.4, 270, 0);
            limboBreakSound(UnknownEnum.Value_9);
            scrRecharge();
            
            if (global.pugExplodingKnees)
            {
                instance_create(x, y, bulletBlast);
                soundPlay(choose(91, 92, 93), 60, 0, 1);
            }
            
            scrFlashballfx(xx, yy, 1, 0, 0);
            scrCurrencySpawn(10);
            myGem.attracted = 1;
            
            repeat (3)
                instance_create(x, y, limboShard);
            
            instance_destroy();
        }
    }
}

enum UnknownEnum
{
    Value_9 = 9
}
