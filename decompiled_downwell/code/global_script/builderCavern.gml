function builderCavern()
{
    switch (string_char_at(levelStr, i))
    {
        case "A":
            break;
        
        case "I":
            instance_create(buildx, y + (16 * k), Torch);
            break;
        
        case "J":
            instance_create(buildx, y + (16 * k), Torch);
            break;
        
        case "^":
            if (choose(0, 1, 1, 1, 1))
                instance_create(buildx, y + (16 * k), Scattered16);
            
            break;
    }
    
    if (random(global.level + 2) <= global.level || (global.hardMode && random(5) > 1))
    {
        switch (string_char_at(levelStr, i))
        {
            case "a":
                instance_create(buildx, y + (16 * k), enmSnake);
                break;
            
            case "b":
                instance_create(buildx, y + (16 * k), enmBat);
                break;
            
            case "c":
                if (global.level >= 2)
                {
                    if (choose(0, 1))
                        instance_create(buildx, y + (16 * k), enmCrawler);
                }
                
                break;
            
            case "d":
                instance_create(buildx, y + (16 * k), enmFrog);
                break;
            
            case "e":
                instance_create(buildx, y + (16 * k), enmSnail);
                break;
            
            case "t":
                instance_create(buildx, y + (16 * k), enmGroundTurtle);
                break;
            
            case "%":
                instance_create(buildx, y + (16 * k), choose(enmFrog, enmSnake, enmCrawler, enmGroundTurtle));
                break;
        }
    }
}
