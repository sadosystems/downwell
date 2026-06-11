function builderCatacomb()
{
    switch (string_char_at(levelStr, i))
    {
        case "A":
            instance_create(buildx, y + (16 * k), objSpike_n);
            break;
        
        case "M":
            instance_create(buildx, y + (16 * k), spikeTrap);
            break;
        
        case "I":
            break;
        
        case "J":
            if (choose(0, 1, 1))
                instance_create(buildx, y + (16 * k), Torch);
            
            break;
        
        case "Z":
            instance_create(buildx, y + (16 * k), catacombThings);
            break;
        
        case "Y":
            if (choose(0, 1, 1))
                instance_create(buildx, y + (16 * k), Cobweb);
            
            break;
        
        case "P":
            instance_create(buildx, y + (16 * k), Chain);
            break;
        
        case "a":
            if (choose(0, 1) == 1)
                instance_create(buildx, y + (16 * k), enmSnake);
            
            break;
        
        case "b":
            if (choose(0, 0, 0, 1))
                instance_create(buildx, y + (16 * k), enmBat);
            
            break;
        
        case "c":
            if (choose(0, 1) == 1)
                instance_create(buildx, y + (16 * k), choose(enmJumpySkull));
            
            break;
        
        case "d":
            if (choose(0, 1) == 1)
            {
                instance_create(buildx + 8, y + (16 * k), enmJumpySkull);
                instance_create(buildx - 8, y + (16 * k), enmJumpySkull);
            }
            
            break;
        
        case "e":
            if (random(5) < global.level)
                instance_create(buildx, y + (16 * k), enmSkeleton);
            
            break;
        
        case "i":
            instance_create(buildx, y + (16 * k), enmSpider);
            break;
        
        case "j":
            if (choose(0, 1) == 1)
                instance_create(buildx, y + (16 * k), enmSkeleton);
            
            break;
        
        case "%":
            spawnChance = irandom(global.level);
            
            switch (global.level)
            {
                case 1:
                    spawnChance = choose(0, 0, 1);
                    break;
                
                case 2:
                    spawnChance = choose(0, 1);
                    break;
                
                case 3:
                    spawnChance = choose(0, 0, 1, 1, 1);
                    break;
            }
            
            if (global.hardMode)
                spawnChance = 1;
            
            if (spawnChance)
            {
                if (global.level <= 2)
                    instance_create(buildx, y + (16 * k), choose(enmJumpySkull, enmJumpySkull, enmSnake));
                else if (global.level == 3)
                    instance_create(buildx, y + (16 * k), choose(enmJumpySkull, enmJumpySkull));
            }
            
            break;
    }
}
