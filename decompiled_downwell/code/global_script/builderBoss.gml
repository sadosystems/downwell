function builderBoss()
{
    switch (string_char_at(levelStr, i))
    {
        case "A":
            instance_create(buildx, y + (16 * k), coralSpike);
            break;
        
        case "C":
            instance_create(buildx, y + (16 * k), limboDebris);
            break;
        
        case "M":
            instance_create(buildx, y + (16 * k), spikeTrap);
            break;
        
        case "T":
            instance_create(buildx, y + (16 * k), airTank);
            break;
        
        case "`":
            repeat (4)
                instance_create(buildx + random_range(-32, 32), y + (16 * k) + random_range(-16, 16), airBubbleMicro);
            
            break;
        
        case ",":
            repeat (4)
                instance_create(buildx + random_range(-32, 32), y + (16 * k) + random_range(-16, 16), limboShard);
            
            break;
        
        case "Q":
            if (!bossItemSpawn)
            {
                if (FINALBOSS.state != 1)
                {
                    bossItemSpawn = 1;
                    instance_create(buildx, y + (16 * k), GunModule);
                }
            }
            
            break;
        
        case "9":
            instance_create(buildx, y + (16 * k), TomatoObtainable);
            break;
        
        case "I":
            break;
        
        case "J":
            if (choose(0, 1))
                instance_create(buildx, y + (16 * k), Torch);
            
            break;
        
        case "Z":
            instance_create(buildx, y + (16 * k), catacombThings);
            break;
        
        case "z":
            instance_create(buildx, y + (16 * k), FINALBOSS);
            break;
        
        case "q":
            instance_create(buildx, y + (16 * k), Cat);
            break;
        
        case "c":
            break;
        
        case "j":
            break;
    }
}
