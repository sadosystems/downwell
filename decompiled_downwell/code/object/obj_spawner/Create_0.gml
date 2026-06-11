depthMeasure = 0;
totalDepthCount = 500;
falldepthMem = 0;
fromAbove = 0;
spawnMin = 200;
spawnMax = 300;

if (global.area == 1)
{
    enm[0] = 115;
    enm[1] = 116;
    enm[2] = 116;
    enmAbove[0] = 118;
    enmMax = global.level - 1;
    
    if (enmMax >= 2)
        enmMax = 2;
    
    if (global.level >= 3)
        fromAbove = 0;
    
    lowSpawn = global.level + 1;
    aboveSpawn = global.level + 1;
}
else if (global.area == 2)
{
    enm[0] = 121;
    enm[1] = 121;
    enm[2] = 118;
    enmAbove[0] = 118;
    enmMax = global.level;
    
    if (enmMax <= 0)
        enmMax = 0;
    
    if (enmMax >= 2)
        enmMax = 2;
    
    if (global.level >= 2)
        fromAbove = 1;
    
    lowSpawn = global.level + 1;
    aboveSpawn = global.level + 1;
}
else if (global.area == 3)
{
    enm[0] = 114;
    enm[1] = 119;
    enm[2] = 157;
    enm[3] = 195;
    enm[4] = 115;
    enm[5] = 118;
    enm[6] = 109;
    enm[7] = 203;
    enmAbove[0] = 136;
    enmMax = 3;
    
    if (global.level >= 1)
        fromAbove = 1;
    
    spawnMin = 50;
    spawnMax = 100;
    lowSpawn = 1;
    aboveSpawn = 0;
}
