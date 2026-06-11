function scrShotSound()
{
    soundPlayOL(global.pBulSound, 80, 0, 1, "gunshot");
    shotSound = global.pBulSound;
    pitch = audio_sound_get_pitch(sndsnd);
    shotgain = audio_sound_get_gain(sndsnd);
    
    if ((global.stammo / global.ammo) <= 0.5)
    {
        if (global.area != 3)
            pitch += 0.8;
        else
            pitch += 0.4;
        
        soundPlayOL(90, 85, 0, 1, "UI");
    }
    
    audio_sound_pitch(shotSound, pitch);
}
