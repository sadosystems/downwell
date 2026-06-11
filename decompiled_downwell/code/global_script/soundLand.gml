function soundLand()
{
    landOn = 0;
    landOn = instance_place(x, y + 2, sParentSolid);
    
    if (landOn && !global.death && !napping)
    {
        sfxIndex = 0;
        
        switch (landOn.material)
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
        
        if (!audio_is_playing(sfxGunRecharge))
            soundPlayOL(global.sfxJl[sfxIndex][irandom_range(1, global.sfxJl[sfxIndex][0])], 60, 0, 1, "footsteps");
    }
}
