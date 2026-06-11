function scrTypicalExplosionDamage()
{
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
                    scrDamageEnemy(bdmg);
                    soundPlay(29, 90, 0, 1);
                    scrBulletImpact();
                    scrEffectSpawn(x, y, 605, 0.4, bDir, 0);
                    momentDelay();
                }
            }
        }
    }
}
