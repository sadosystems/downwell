switch (spawnArea)
{
    case 1:
        with (objBuilder)
            scrBossPat2();
        
        myTentacle.bodyDistance = 288;
        break;
    
    case 2:
        with (objBuilder)
            scrBossPat2();
        
        myTentacle.bodyDistance = 256;
        break;
    
    case 3:
        with (objBuilder)
            scrBossPat3();
        
        myTentacle.bodyDistance = 272;
        myWaterLine = instance_create(x, objBuilder.y, WaterLine);
        break;
    
    case 4:
        with (objBuilder)
            scrBossPat4();
        
        myTentacle.bodyDistance = 240;
        
        if (global.gInWater)
        {
            instance_create(x, objBuilder.y, WaterLineBottom);
            
            with (myWaterLine)
                instance_destroy();
        }
        
        break;
}
