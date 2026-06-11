function scrBulCheckSolidBounce()
{
    if (collision_line(x, y, x + xsp, y + ysp, subparentSolidWall, 0, 0) && !collision_line(x, y, x + xsp, y + ysp, subparentEnemy, 0, 0))
    {
        thatWall = collision_line(x, y, x + xsp, y + ysp, subparentSolidWall, 0, 0);
        whileStop = 0;
        
        while (0)
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
                
                if (!bConsistent)
                    instance_destroy();
            }
        }
        else if (!bWave)
        {
            scrEffectSpawn(x, y, hitWallFx, 0.5, 0, 0);
            soundBullet(thatWall);
            bounceAngle();
            allSet = 0;
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
            scrFlashballfx(x, y, 1, 0, 0);
            
            if (!bConsistent)
                instance_destroy();
        }
    }
}
