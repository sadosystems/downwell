function spawnerInit()
{
    depthMeasure = 0;
    totalDepthCount = 500;
    falldepthMem = 0;
    enemyMaxCount = 10;
    fromAbove = 0;
    active = 0;
    
    if (!global.hardMode)
    {
        switch (global.area)
        {
            case 1:
                spawnerSet1();
                break;
            
            case 2:
                spawnerSet2();
                break;
            
            case 4:
                spawnerSet3();
                break;
            
            case 3:
                spawnerSet4();
                break;
            
            case 5:
                spawnerSet5();
                break;
        }
    }
    else
    {
        switch (global.area)
        {
            case 1:
                hardSet1();
                break;
            
            case 2:
                hardSet2();
                break;
            
            case 4:
                hardSet3();
                break;
            
            case 3:
                hardSet4();
                break;
            
            case 5:
                spawnerSet5();
                break;
        }
    }
}
