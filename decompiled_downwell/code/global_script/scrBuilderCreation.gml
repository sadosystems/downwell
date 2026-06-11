function scrBuilderCreation()
{
    extraColumn = 4;
    pixelBuilt = 0;
    levelLength = 15;
    chunkOrCrate = 0;
    spawnerMade = 0;
    
    if (global.area <= 1)
    {
        scrLevelPat1();
    }
    else if (global.area == 2)
    {
        scrLevelPat2();
        
        if (global.hardMode)
            instance_create(0, 0, hardSpikeController);
    }
    else if (global.area == 3)
    {
        scrLevelPat4();
        
        if (global.level >= 2)
            instance_create(160, 0, WaterLine);
    }
    else if (global.area == 4)
    {
        if (!global.hardMode)
            scrLevelPat3();
        
        if (global.hardMode)
        {
            scrLevelPatLimboHard();
            global.wrapMode = 0;
        }
        
        if (global.level == 1)
            instance_create(160, 640, WaterLineBottom);
    }
    else if (global.area == 5)
    {
        scrLevelPat6();
        levelLength = 1000;
        rightRoomAmt = 0;
        rightRoomMade = 0;
        leftRoomAmt = 0;
    }
    
    global.newline = "\n";
    levelPixelLength = 99999;
    buildFiller = -1;
    leftRoomAmt = 0;
    prvstr = -1;
    randLevel = 0;
    makeShop = 0;
    reverseBuild = 0;
    setPillar = 1;
    
    if (global.wrapMode)
        setPillar = 0;
    
    endReached = 0;
    chestPlacement = -1;
    gspherePlacement = -1;
    bigHeartSpawned = 0;
    global.builderPoint = y;
    
    if (global.pugMember)
        rightRoomAmt += 1;
    
    for (i = 1; i <= rightRoomAmt; i += 1)
        sideRoomLog[i] = -1;
    
    for (i = 1; i <= rightRoomAmt; i += 1)
    {
        if (i > 1)
        {
            wl = 0;
            
            while (true)
            {
                sameNumNoGo = 0;
                rightRoom[i] = irandom_range(3, levelLength - 1);
                
                for (chk = 1; chk <= i; chk += 1)
                {
                    if (rightRoom[i] == rightRoom[i - chk])
                        sameNumNoGo = 1;
                    
                    if (rightRoom[i] == (rightRoom[i - chk] - 1))
                        sameNumNoGo = 1;
                    
                    if (rightRoom[i] == (rightRoom[i - chk] + 1))
                        sameNumNoGo = 1;
                    
                    if (rightRoom[i] == (rightRoom[i - chk] - 2))
                        sameNumNoGo = 1;
                    
                    if (rightRoom[i] == (rightRoom[i - chk] + 2))
                        sameNumNoGo = 1;
                }
                
                if (!sameNumNoGo)
                    break;
                
                wl += 1;
                
                if (wl > 100)
                {
                    rightRoom[i] = 9999;
                    break;
                }
            }
        }
        else
        {
            rightRoom[1] = irandom_range(3, levelLength - 1);
            
            if (global.pugMember)
                rightRoom[1] = 0;
        }
    }
    
    for (i = 1; i <= leftRoomAmt; i += 1)
    {
        if (i > 1)
        {
            wl = 0;
            
            while (true)
            {
                sameNumNoGo = 0;
                leftRoom[i] = irandom(levelLength);
                
                for (chk = 1; chk <= (leftRoomAmt - 1); chk += 1)
                {
                    if (leftRoom[i] == leftRoom[i - chk])
                        sameNumNoGo = 1;
                    
                    if (leftRoom[i] == (leftRoom[i - chk] + 1))
                        sameNumNoGo = 1;
                    
                    if (leftRoom[i] == (leftRoom[i - chk] - 1))
                        sameNumNoGo = 1;
                    
                    if (leftRoom[i] == (leftRoom[i - chk] + 2))
                        sameNumNoGo = 1;
                    
                    if (leftRoom[i] == (leftRoom[i - chk] - 2))
                        sameNumNoGo = 1;
                }
                
                for (chk = 1; chk <= rightRoomAmt; chk += 1)
                {
                    if (leftRoom[i] == rightRoom[chk])
                        sameNumNoGo = 1;
                }
                
                if (!sameNumNoGo)
                    break;
                
                wl += 1;
                
                if (wl > 100)
                {
                    leftRoom[i] = -1000;
                    break;
                }
            }
        }
        else
        {
            wl = 0;
            
            while (true)
            {
                sameNumNoGo = 0;
                leftRoom[1] = irandom(levelLength);
                
                for (chk = 1; chk <= rightRoomAmt; chk += 1)
                {
                    if (leftRoom[1] == rightRoom[chk])
                        sameNumNoGo = 1;
                }
                
                if (!sameNumNoGo)
                    break;
                
                wl += 1;
                
                if (wl > 100)
                {
                    leftRoom[i] = -100;
                    break;
                }
            }
        }
    }
}
