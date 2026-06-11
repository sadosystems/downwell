if (!global.pTimeStop)
{
}

y = round(yy);

if (!opened)
{
    if (collision_rectangle(xx - 8, yy - 10, xx + 8, yy, objPlayer_n, 0, 0))
    {
        wallHp = 0;
        scrFjump(0, 4);
        scrEffectSpawn(global.plx, global.ply, 111, 1, 0, -50001);
        scrEffectSpawn(x, y, 660, 0.5, 0, -50500);
        
        with (objPlayer_n)
        {
            global.spinJumping = 0;
            global.yayJumping = 1;
            image_index = 0;
        }
    }
    
    if (wallHp <= 0)
    {
        opened = 1;
        soundPlay(183, 85, 0, 1);
        scrFlashballfx(x, y, 1, 0, 2);
        myOpen = instance_create(x, y, objOpenedCrate);
        lightFlashing = 1;
        myLid = instance_create(x, y + 8, fxCrateLid);
        emitSmoke(x + 8, y, 0, 4);
        emitSmoke(x - 8, y, 180, 4);
        emitSmoke(x + 8, y, 10, 3);
        emitSmoke(x - 8, y, 170, 3);
        instance_create(x, y - 8, GunModule);
        instance_destroy();
    }
}
