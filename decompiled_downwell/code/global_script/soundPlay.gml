function soundPlay(arg0, arg1, arg2, arg3)
{
    sfxIndex = arg0;
    soundPriority = arg1;
    loop = arg2;
    cutPrv = arg3;
    
    if (cutPrv)
    {
        if (audio_is_playing(sfxIndex))
            audio_stop_sound(sfxIndex);
    }
    
    sndsnd = audio_play_sound(sfxIndex, soundPriority, loop);
    sndgain = audio_sound_get_gain(sndsnd);
    sndgain *= global.gameVolume;
    audio_sound_gain(sndsnd, sndgain, 0);
    
    if (global.gInWater)
        audio_sound_pitch(sndsnd, 0.55);
    else
        audio_sound_pitch(sndsnd, 1);
    
    return sndsnd;
}
