function scrEnemyStomped()
{
    if (!global.death)
    {
        scrBloodfx(3, 0);
        
        if (global.playStyle == 2)
            scrFjump(0, 1.5);
        else
            scrFjump(0, 2.5);
        
        scrSShake(2, 10);
        scrDamageToEnemy(100);
        soundPlayOL(122, 50, 0, 1, "footsteps");
        scrRecharge(global.rechargeAmount);
        hit = 1;
        stomped = 1;
        
        if (global.pugExplodingKnees)
        {
            instance_create(x, y, bulletBlast);
            soundPlay(choose(91, 92, 93), 60, 0, 1);
            emitSmoke(global.plx, global.ply + 4, 0, 4);
            emitSmoke(global.plx, global.ply + 4, 180, 4);
            emitSmoke(global.plx, global.ply + 4, 15, 3);
            emitSmoke(global.plx, global.ply + 4, 165, 3);
        }
    }
}
