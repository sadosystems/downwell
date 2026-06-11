function soundBullet(arg0)
{
    sfxIndex = 0;
    
    switch (arg0.material)
    {
        case "breakable":
            sfxIndex = 0;
            break;
        
        case "thin":
            sfxIndex = 1;
            break;
        
        case "foliage":
            sfxIndex = 2;
            break;
        
        case "rock":
            sfxIndex = 3;
            break;
        
        case "metal":
            sfxIndex = 4;
            break;
    }
    
    soundPlayOL(global.sfxBhit[sfxIndex][irandom_range(1, global.sfxBhit[sfxIndex][0])], 60, 0, 1, "gunwall");
}
