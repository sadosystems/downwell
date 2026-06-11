function bgmDuck(arg0, arg1)
{
    duckDuration = arg0;
    duckAmt = arg1;
    
    if (global.area != 5)
    {
        if (audio_is_playing(global.bgm))
        {
            if (audio_sound_get_gain(global.bgm) == 1)
            {
                audio_sound_gain(global.bgm, duckAmt, 0);
                audio_sound_gain(global.bgm, 1, duckDuration);
            }
        }
    }
}
