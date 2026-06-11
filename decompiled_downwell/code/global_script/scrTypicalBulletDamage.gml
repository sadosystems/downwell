function scrTypicalBulletDamage()
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
                    other.hitAngle = point_direction(x, y, other.x, other.y);
                    other.hitDmg += bdmg;
                    scrDamageEnemy(bdmg);
                    soundPlay(29, 90, 0, 1);
                    scrBulletImpact();
                    scrEffectSpawn(x, y, 605, 0.4, bDir, 0);
                    
                    if (!other.hitStun)
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
            other.hitAngle = point_direction(x, y, other.x, other.y);
            instance_destroy();
        }
    }
}
