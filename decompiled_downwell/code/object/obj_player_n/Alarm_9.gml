if (global.gInWater)
{
    if (!global.pTimeStop && !global.playerDamaged)
    {
        if (global.oxygen > 0)
            global.oxygen -= 1;
        
        if (global.oxygen <= 0)
        {
            if (!global.playerDamaged)
            {
                hitInvi = 240;
                
                if (!global.death)
                {
                    if (!global.playerDamaged)
                    {
                        global.playerHp -= 1;
                        scrDmgCalcFxPlayer(1, point_direction(x, y, global.plx, global.ply));
                        soundPlay(5, 90, 0, 0);
                        bgmDuck(500, 0.7);
                        global.pHit = 1;
                        
                        with (objControlerN)
                        {
                            room_speed = 40;
                            slown = 23;
                            alarm[0] = room_speed * 1;
                        }
                    }
                    
                    global.playerDamaged = 1;
                    objPlayer_n.alarm[1] = hitInvi;
                    scrFjump(0, 0.5);
                    
                    if (global.playerHp > 0)
                        scrEffectSpawn(global.plx, global.ply, 114, 0.4, 0, -100000);
                }
            }
        }
    }
}
else
{
    global.oxygen = 100;
}

if (global.oxygen <= 100)
    alarm[9] = global.oxygenDepRate;
else
    alarm[9] = global.oxygenDepRate / 2;
