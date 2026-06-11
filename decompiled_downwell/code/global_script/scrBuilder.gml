function scrBuilder()
{
    if ((y - (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0))) < 128 && !endReached)
    {
        makeShop = 0;
        sideRoomGeneration = 0;
        levelStr = "none";
        pixelBuilt = y - ystart;
        
        if (pixelBuilt >= levelPixelLength)
            genCount = levelLength + 1;
        
        if (genCount <= levelLength)
        {
            if (genCount < -1)
            {
                levelStr = "\r\n.........\r\n.........";
                genCount += 1;
            }
            else if (genCount == -1)
            {
                randLevel = irandom(partStart[100]);
                levelStr = partStart[randLevel];
                genCount += 1;
            }
            else
            {
                if (!spawnerMade)
                {
                    instance_create(x - 100, y, Spawner);
                    spawnerMade = 1;
                }
                
                for (i = 1; i <= rightRoomAmt; i += 1)
                {
                    if (genCount == rightRoom[i])
                    {
                        rightRoomMade += 1;
                        
                        if (!shopMade)
                        {
                            if (global.playStyle == 1)
                            {
                                makeShop = choose(0, 0, 0, 0, 0, 0, 1);
                            }
                            else if (global.playStyle == 4)
                            {
                                if (rightRoomMade >= rightRoomAmt)
                                    makeShop = 1;
                            }
                            else
                            {
                                makeShop = choose(0, 1);
                            }
                            
                            if (global.pugMember)
                                makeShop = 1;
                        }
                        
                        if (makeShop)
                        {
                            randLevel = irandom(partShopR[100]);
                            levelStr = partShopR[randLevel];
                            shopMade += 1;
                        }
                        else
                        {
                            wl = 0;
                            
                            while (true)
                            {
                                wl += 1;
                                reShuffle = 0;
                                randLevel = irandom(partRight[100]);
                                
                                for (rm = 1; rm <= rightRoomAmt; rm += 1)
                                {
                                    if (sideRoomLog[rm] == randLevel)
                                        reShuffle += 1;
                                }
                                
                                if (!reShuffle)
                                    break;
                                else if (wl > 60)
                                    break;
                            }
                            
                            sideRoomLog[i] = randLevel;
                            levelStr = partRight[randLevel];
                        }
                        
                        genCount += 1;
                        sideRoomGeneration = 1;
                    }
                }
            }
            
            if (levelStr == "none")
            {
                if (global.area == 3)
                {
                    if (buildFiller)
                    {
                        randLevel = irandom(partFiller[100]);
                        levelStr = partFiller[randLevel];
                        
                        if (!global.hardMode)
                        {
                            buildFiller = -1;
                        }
                        else
                        {
                            buildFiller += 1;
                            
                            if (buildFiller > 2)
                                buildFiller = -1;
                        }
                    }
                    else
                    {
                        randLevel = irandom(partMain[100]);
                        
                        while (randLevel == prvstr)
                            randLevel = irandom(partMain[100]);
                        
                        levelStr = partMain[randLevel];
                        prvstr = randLevel;
                        genCount += 1;
                        buildFiller = 1;
                    }
                }
                else
                {
                    randLevel = irandom(partMain[100]);
                    
                    while (randLevel == prvstr)
                        randLevel = irandom(partMain[100]);
                    
                    levelStr = partMain[randLevel];
                    prvstr = randLevel;
                    genCount += 1;
                }
            }
        }
        else if (genCount > levelLength)
        {
            randLevel = irandom(partEnd[100]);
            levelStr = partEnd[randLevel];
            endReached = 1;
        }
        
        k = 0;
        t = 0;
        
        if (!makeShop)
            reverseBuild = choose(0, 1);
        else
            reverseBuild = 0;
        
        if (global.debugMode)
        {
        }
        
        if (genCount == 0)
        {
            if (global.area == 5)
                reverseBuild = 0;
        }
        
        for (i = 1; i <= string_length(levelStr); i += 1)
        {
            if (string_char_at(levelStr, i) == "\t")
            {
                string_delete(levelStr, i, 1);
            }
            else if (i < 3 && (string_char_at(levelStr, i) == "\r" || string_char_at(levelStr, i) == global.newline))
            {
                string_delete(levelStr, i, 1);
            }
            else
            {
                t += 1;
                scrSetBuildx();
                
                switch (global.area)
                {
                    case 1:
                        builderCavern();
                        break;
                    
                    case 2:
                        builderCatacomb();
                        break;
                    
                    case 3:
                        builderAquifer();
                        break;
                    
                    case 4:
                        builderLimbo();
                        break;
                    
                    case 5:
                        builderBoss();
                        break;
                }
                
                switch (string_char_at(levelStr, i))
                {
                    case "1":
                        with (instance_create(buildx, y + (16 * k), objWall_n))
                            deactivate = 1;
                        
                        break;
                    
                    case "2":
                        if (choose(0, 1))
                        {
                            with (instance_create(buildx, y + (16 * k), objWall_n))
                                deactivate = 1;
                        }
                        
                        break;
                    
                    case "3":
                        if (choose(0, 1))
                        {
                            with (instance_create(buildx, y + (16 * k), objBox_n))
                                instance_deactivate_object(self);
                        }
                        
                        break;
                    
                    case "-":
                        instance_create(buildx, y + (16 * k), objThinPlatform);
                        break;
                    
                    case "B":
                        with (instance_create(buildx, y + (16 * k), objBox_n))
                            instance_deactivate_object(self);
                        
                        break;
                    
                    case "W":
                        instance_create(buildx, y + (16 * k), objWaterTop_n);
                        break;
                    
                    case "N":
                        instance_create(buildx, y + (16 * k), npcTest);
                        break;
                    
                    case "$":
                        instance_create(buildx, y + (16 * k), Shop);
                        break;
                    
                    case "\\":
                        instance_create(buildx, y + (16 * k), shopSign);
                        break;
                    
                    case "v":
                        instance_create(buildx, y + (16 * k), voidAmbience);
                        break;
                    
                    case "@":
                        if (chunkOrCrate == 0)
                            chunkOrCrate = choose(293, 109);
                        else if (chunkOrCrate == 109)
                            chunkOrCrate = 293;
                        else
                            chunkOrCrate = 109;
                        
                        if (global.playerHp <= 2)
                        {
                            if (chunkOrCrate != 109)
                            {
                                if (choose(0, 1, 1, 1, 1, 1))
                                    chunkOrCrate = 109;
                            }
                        }
                        
                        if (global.playStyle == 1)
                            chunkOrCrate = 109;
                        
                        instance_create(buildx, y + (16 * k), chunkOrCrate);
                        break;
                    
                    case "+":
                        instance_create(buildx, y + (16 * k), GunModule);
                        break;
                    
                    case "O":
                        instance_create(buildx, y + (16 * k), parentTimeField);
                        break;
                    
                    case "?":
                        if (choose(0, 0, 0, 1))
                            instance_create(buildx, y + (16 * k), choose(Crate));
                        
                        break;
                    
                    case "=":
                        instance_create(buildx, y + (16 * k), objLineToResult);
                        break;
                    
                    case "_":
                        instance_create(buildx, y + (16 * k), sideCamLocker);
                        break;
                    
                    case "|":
                        instance_create(buildx, y + (16 * k), objWall_n);
                        break;
                    
                    case "{":
                        if (buildx < (room_width / 2))
                            sideroomRightmost = -16;
                        else
                            sideroomRightmost = (room_width - 160) + 16;
                        
                        with (instance_create(sideroomRightmost, y, objWall_n))
                        {
                            mask_index = mask11x3up;
                            i = 15;
                            image_index = 15;
                            checked = 1;
                        }
                        
                        break;
                    
                    case "}":
                        if (buildx < (room_width / 2))
                            sideroomRightmost = -16;
                        else
                            sideroomRightmost = (room_width - 160) + 16;
                        
                        with (instance_create(sideroomRightmost, y, objWall_n))
                        {
                            mask_index = mask11x3down;
                            i = 15;
                            image_index = 15;
                            checked = 1;
                        }
                        
                        break;
                    
                    case "\t":
                        t -= 1;
                        break;
                    
                    case global.newline:
                    case "\r":
                        if (i > 1)
                        {
                            i += 1;
                            scrSetBuildx();
                            
                            if (setPillar)
                            {
                                with (instance_create(buildx, y + (16 * k), objWall_n))
                                {
                                    if (x > (room_width / 2))
                                        isPillar = 1;
                                    else
                                        isPillar = -1;
                                }
                            }
                            
                            t = 0;
                            scrSetBuildx();
                            
                            if (setPillar)
                            {
                                with (instance_create(buildx, y + (16 * k), objWall_n))
                                {
                                    if (x > (room_width / 2))
                                        isPillar = 1;
                                    else
                                        isPillar = -1;
                                }
                            }
                            
                            y += 16;
                        }
                        else
                        {
                            t = 0;
                        }
                        
                        break;
                    
                    default:
                        break;
                }
                
                p = 0;
            }
        }
        
        if (genCount > 0)
        {
            sideRoomGeneration = 0;
            
            repeat (extraColumn + 1)
            {
                t = 0;
                scrSetBuildx();
                
                if (setPillar)
                {
                    with (instance_create(buildx, y + (16 * k), objWall_n))
                    {
                        if (x > (room_width / 2))
                            isPillar = 1;
                        else
                            isPillar = -1;
                    }
                }
                
                t = 10;
                scrSetBuildx();
                
                if (setPillar)
                {
                    with (instance_create(buildx, y + (16 * k), objWall_n))
                    {
                        if (x > (room_width / 2))
                            isPillar = 1;
                        else
                            isPillar = -1;
                    }
                }
                
                y += 16;
            }
        }
        
        global.builderPoint = y;
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
