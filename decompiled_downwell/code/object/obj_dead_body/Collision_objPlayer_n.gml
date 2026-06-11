if (global.pugKnifefork && !global.death)
{
    if (active)
    {
        global.bodiesEaten += 1;
        soundPlayOL(83, 80, 0, 1, "UI");
        
        repeat (5)
            instance_create(global.plx, global.ply, fxBlood);
        
        instance_destroy();
    }
}
