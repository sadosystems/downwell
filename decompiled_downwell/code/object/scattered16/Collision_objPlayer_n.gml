if (active && objPlayer_n.ysp > 0)
{
    objHp = 0;
    stomped = 1;
    
    if (global.playStyle == 2)
        scrFjump(0, 1.5);
    else
        scrFjump(0, 2.5);
    
    scrSShake(2, 4);
    
    if (global.pugExplodingKnees)
    {
        instance_create(x, y, bulletBlast);
        soundPlay(choose(91, 92, 93), 60, 0, 1);
    }
}
