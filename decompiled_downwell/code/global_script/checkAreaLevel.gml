function checkAreaLevel()
{
    reached = 10;
    reached = global.area * 10;
    reached += global.level;
    
    if (global.bossDead == 2)
        reached = 90;
    
    if (global.hardMode)
        reached += 100;
    
    if (reached > global.recordFurthestReached)
        global.recordFurthestReached = reached;
}
