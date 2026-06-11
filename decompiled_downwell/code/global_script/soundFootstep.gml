function soundFootstep()
{
    landOn = 0;
    landOn = instance_place(x, y + 2, sParentSolid);
    
    if (landOn)
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
        
        footstepsnd = -1;
        footstepsnd = soundPlayOL(global.sfxFs[sfxIndex][irandom_range(1, global.sfxFs[sfxIndex][0])], 60, 0, 1, "footsteps");
        
        if (global.pTimeStop || groundRoom() || atPit)
        {
            sndgain = audio_sound_get_gain(sndsnd);
            sndgain *= 1;
            audio_sound_gain(sndsnd, sndgain, 0);
        }
        else
        {
            sndgain = audio_sound_get_gain(sndsnd);
            sndgain *= 0.7;
            audio_sound_gain(sndsnd, sndgain, 0);
        }
    }
}
