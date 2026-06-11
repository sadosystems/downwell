if (!global.death)
{
    if (state == 0)
    {
        repeat (choose(1, 1, 1))
        {
            switch (spawnArea)
            {
                case 1:
                    spawnEnemy = choose(171, 172, 173);
                    break;
                
                case 2:
                    spawnEnemy = choose(174, 175);
                    break;
                
                case 3:
                    spawnEnemy = choose(177, 178);
                    break;
                
                case 4:
                    spawnEnemy = choose(159, 160, 159);
                    break;
            }
            
            if (instance_number(subparentEnemy) < 6)
            {
                randxGrid = 160 + (16 * choose(2, 3, 7, 8));
                snappyViewh = round((__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)) / 16) * 16;
                randyGrid = y + irandom_range(-16, 8);
                wl = 0;
                
                while (true)
                {
                    if (!collision_circle(randxGrid, randyGrid, 10, parentWall, 0, 0) && !collision_circle(randxGrid, randyGrid, 10, parentWall, 0, 0))
                    {
                        break;
                    }
                    else
                    {
                        randxGrid = 160 + (16 * irandom_range(1, 9));
                        randyGrid = y + irandom_range(-16, 8);
                    }
                    
                    wl += 1;
                    
                    if (wl > 32)
                        break;
                }
                
                if (!place_meeting(randxGrid, randyGrid, parentWall) && wl < 32)
                {
                    with (instance_create(randxGrid, randyGrid, spawnEnemy))
                    {
                        money = 40;
                        ehp = 10;
                    }
                    
                    emitSmoke(randxGrid, randyGrid, 0, 4);
                    emitSmoke(randxGrid, randyGrid, 180, 4);
                    emitMovingFx(randxGrid, randyGrid, 118, 0.7, 90, 0);
                    emitMovingFx(randxGrid, randyGrid, 119, 0.7, 0, 0);
                    
                    switch (spawnEnemy)
                    {
                        case 171:
                            spawnSound = 213;
                            break;
                        
                        case 172:
                            spawnSound = 217;
                            break;
                        
                        case 173:
                            spawnSound = 218;
                            break;
                        
                        case 174:
                            spawnSound = 216;
                            break;
                        
                        case 175:
                            spawnSound = 214;
                            break;
                        
                        case 177:
                            spawnSound = 220;
                            break;
                        
                        case 178:
                            spawnSound = 219;
                            break;
                        
                        case 159:
                            spawnSound = 212;
                            break;
                        
                        case 160:
                            spawnSound = 215;
                            break;
                    }
                    
                    soundPlayOL(spawnSound, 70, 0, 1, "boss");
                }
            }
        }
        
        if (state == 0)
            shotCount += 1;
    }
    
    if (shotCount < 4)
        alarm[1] = 10;
    else
        shotCount = 0;
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
