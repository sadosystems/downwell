function spawnerStep()
{
    if (!active)
    {
        if (global.ply > y)
        {
            if (global.area != 5)
                active = 1;
        }
    }
    
    if (active)
    {
        depthMeasure = global.falldepth - falldepthMem;
        falldepthMem = global.falldepth;
        
        if (!global.death && !objBuilder.endReached && instance_number(subparentEnemy) < enemyMaxCount)
        {
            for (i = 0; i <= chanMax; i += 1)
            {
                spChannel[i][0] -= depthMeasure;
                
                if (spChannel[i][0] <= 0)
                {
                    spChannel[i][0] = spChannel[i][1] + (irandom(spChannel[i][2]) * choose(-1, 1));
                    spawnAmt = irandom_range(spChannel[i][3], spChannel[i][4]);
                    
                    if (!spChannel[i][5])
                    {
                        repeat (spawnAmt)
                        {
                            spawningEnemy = spEnemy[i][irandom(enemyMax[i])];
                            mask_index = object_get_mask(spawningEnemy);
                            randxGrid = 160 + (16 * irandom_range(2, 8));
                            snappyViewh = (ceil((__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)) / 16) + 1) * 16;
                            randyGrid = snappyViewh + (16 * irandom_range(1, 5));
                            wl = 0;
                            
                            while (true)
                            {
                                if (!place_meeting(randxGrid, randyGrid, parentWall) && !place_meeting(randxGrid, randyGrid, subparentEnemy) && !tile_layer_find(100, randxGrid, randyGrid))
                                {
                                    break;
                                }
                                else
                                {
                                    randxGrid = 160 + (16 * irandom_range(1, 9));
                                    randyGrid = snappyViewh + (16 * irandom_range(1, 5));
                                }
                                
                                wl += 1;
                                
                                if (wl > 32)
                                    break;
                            }
                            
                            if (!place_meeting(randxGrid, randyGrid, parentWall) && wl < 32)
                            {
                                with (instance_create(randxGrid, randyGrid, spawningEnemy))
                                    instance_deactivate_object(self);
                            }
                        }
                    }
                    else
                    {
                        repeat (spawnAmt)
                        {
                            spawningEnemy = spEnemy[i][irandom(enemyMax[i])];
                            mask_index = object_get_mask(spawningEnemy);
                            randxGrid = 160 + (16 * irandom_range(2, 8));
                            snappyViewy = round(__view_get(e__VW.YView, 0) / 16) * 16;
                            randyGrid = snappyViewy - (16 * irandom_range(1, 5));
                            wl = 0;
                            
                            while (true)
                            {
                                if (!place_meeting(randxGrid, randyGrid, parentWall) && !place_meeting(randxGrid, randyGrid, subparentEnemy))
                                {
                                    break;
                                }
                                else
                                {
                                    randxGrid = 160 + (16 * irandom_range(2, 8));
                                    randyGrid = snappyViewy - (16 * irandom_range(1, 5));
                                }
                                
                                wl += 1;
                                
                                if (wl > 32)
                                    break;
                            }
                            
                            if (!place_meeting(randxGrid, randyGrid, parentWall) && wl < 32)
                            {
                                with (instance_create(randxGrid, randyGrid, spawningEnemy))
                                    instance_deactivate_object(self);
                            }
                        }
                    }
                }
            }
        }
    }
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
