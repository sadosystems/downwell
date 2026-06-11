function scrBulCheckSolid()
{
    if (collision_line(x, y, x + xsp, y + ysp, subparentSolidWall, 0, 0) && !collision_line(x, y, x + xsp, y + ysp, subparentEnemy, 0, 0))
    {
        thatWall = collision_line(x, y, x + xsp, y + ysp, subparentSolidWall, 0, 0);
        whileStop = 0;
        
        while (!collision_point(x, y, subparentSolidWall, 0, 0))
        {
            y += (ysp / 10);
            x += (xsp / 10);
            whileStop += 1;
            
            if (whileStop > 100)
                break;
        }
        
        if (object_get_parent(thatWall.object_index) == 84)
        {
            if (thatWall.wallHp > 0)
            {
                thatWall.wallHp -= bdmg;
                thatWall.hit = 1;
                
                if (!bConsistent)
                    instance_destroy();
            }
        }
        else if (!bWave)
        {
            scrEffectSpawn(x, y, hitWallFx, 0.5, 0, 0);
            soundBullet(thatWall);
            instance_destroy();
        }
        
        if (bExplode && !bWave)
            instance_create(x, y, bulletExplosion1);
    }
    else if (place_meeting(x, y, parentShootableThing))
    {
        thatThing = instance_place(x, y, parentShootableThing);
        
        if (thatThing.objHp > 0)
        {
            thatThing.objHp -= bdmg;
            thatThing.hit = 1;
            
            if (thatThing.hitEffect)
                scrEffectSpawn(x, y, 605, 0.4, bDir, 0);
            
            if (!bConsistent)
                instance_destroy();
        }
    }
}
