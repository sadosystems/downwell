if (!other.bulletThrough)
{
    if (!other.bulletImmune)
    {
        if (other.ehp > 0)
        {
            hitIgnore = 0;
            
            if (bConsistent)
                hitIgnoreCheck(other);
            
            if (!bConsistent)
            {
                if (bExplode)
                    instance_create(x, y, bulletExplosion1);
                
                instance_destroy();
            }
            
            if (!hitIgnore)
            {
                other.hit = 1;
                other.hitDir = bDir;
                other.hitAngle = 270;
                other.hitDmg += bdmg;
                
                if (other.ehp > bdmg)
                    instance_destroy();
                
                scrBloodfx(3, 0);
                scrDamageEnemy(bdmg);
                scrFlashballfx(x, y, 1, 0, 2);
                soundPlay(16, 50, 0, 1);
                scrBulletImpact();
                instance_create(x, y, fxHit);
                momentDelay();
            }
        }
    }
    else
    {
        scrEffectSpawn(x, y, 112, 0.3, 0, 10000);
        soundPlay(choose(30, 31), 50, 0, 1);
        other.hit = 1;
        other.hitDir = bDir;
        other.hitAngle = 270;
        instance_destroy();
    }
}
