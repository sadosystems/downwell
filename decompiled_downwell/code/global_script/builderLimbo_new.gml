function builderLimbo_new()
{
    switch (string_char_at(levelStr, i))
    {
        case "A":
            instance_create(buildx, y + (16 * k), objSpike_n);
            break;
        
        case "^":
            if (choose(0, 1))
                instance_create(buildx, y + (16 * k), objSpike_n);
            
            break;
        
        case "C":
            instance_create(buildx, y + (16 * k), limboDebris);
            break;
        
        case "a":
            break;
        
        case "b":
            if (choose(0, 1) == 1)
                instance_create(buildx, y + (16 * k), enmEyefish);
            
            break;
        
        case "c":
            break;
        
        case "d":
            if (!global.hardMode)
            {
                if (choose(0, 1) == 1)
                    instance_create(buildx, y + (16 * k), gasSpin);
            }
            
            break;
        
        case "%":
            if (choose(0, 1) == 1)
                instance_create(buildx, y + (16 * k), choose(enmCrawler, enmCrawler));
            
            break;
    }
}
