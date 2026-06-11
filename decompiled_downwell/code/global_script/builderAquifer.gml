function builderAquifer()
{
    switch (string_char_at(levelStr, i))
    {
        case "A":
            instance_create(buildx, y + (16 * k), coralSpike);
            break;
        
        case "G":
            break;
        
        case "S":
            instance_create(buildx, y + (16 * k), GateSwitch);
            break;
        
        case "Y":
            break;
        
        case "T":
            if (!global.hardMode)
                instance_create(buildx, y + (16 * k), choose(Clam));
            
            break;
        
        case "`":
            repeat (4)
                instance_create(buildx + random_range(-32, 32), y + (16 * k) + random_range(-16, 16), airBubbleMicro);
            
            break;
        
        case "~":
            instance_create(160, y + (16 * k), WaterLine);
            break;
        
        case "c":
            break;
        
        case ">":
            instance_create(buildx, y + (16 * k), enmShooter);
            break;
        
        case "%":
            break;
    }
}
