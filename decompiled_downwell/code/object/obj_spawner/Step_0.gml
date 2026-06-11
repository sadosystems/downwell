if (global.ply > y)
{
    depthMeasure = global.falldepth - falldepthMem;
    
    if (!global.death && !objBuilder.endReached)
        totalDepthCount -= depthMeasure;
    
    falldepthMem = global.falldepth;
    
    if (totalDepthCount <= 0)
    {
        if (instance_number(subparentEnemy) < 20)
        {
            repeat (lowSpawn)
            {
                randxGrid = 160 + (16 * irandom_range(1, 9));
                randyGrid = ceil(__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + (((16 * irandom_range(1, 5)) / 16) * 16));
                
                if (!place_meeting(randxGrid, randyGrid, parentWall))
                    instance_create(randxGrid, randyGrid, enm[irandom(enmMax)]);
            }
            
            if (fromAbove)
            {
                repeat (irandom(aboveSpawn))
                {
                    randxGrid = 160 + (16 * irandom_range(1, 9));
                    randyGrid = ceil(__view_get(e__VW.YView, 0) - (((16 * irandom_range(1, 5)) / 16) * 16));
                    
                    if (!position_meeting(randxGrid, randyGrid, parentWall))
                        instance_create(randxGrid, randyGrid, enmAbove[0]);
                }
            }
        }
        
        totalDepthCount = irandom_range(spawnMin, spawnMax);
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
