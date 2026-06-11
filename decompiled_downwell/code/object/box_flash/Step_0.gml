if (phase == 0)
{
    ysize += yssp;
    scrSShake(1, 2);
    camMain.camShakeAmt = 1;
    yssp *= 1.5;
    
    if (ysize > 800)
    {
        phase = 1;
        alarm[0] = 138;
        global.wallTile = 51;
    }
}

if (phase == 2)
{
    xsize *= 0.925;
    
    if (xsize < 0.2)
        instance_destroy();
}
