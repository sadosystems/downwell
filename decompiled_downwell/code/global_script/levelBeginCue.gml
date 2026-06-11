function levelBeginCue()
{
    if (!global.firstLand && !global.pTimeStop)
    {
        if (global.area != 5)
        {
            instance_create(x, y, levelNumber);
            global.firstLand = 1;
            
            if (audio_is_playing(sfxFalling))
                audio_stop_sound(sfxFalling);
            
            if (global.bgm != global.areaBgm[global.area])
                global.bgm = global.areaBgm[global.area];
            
            if (!audio_is_playing(global.bgm))
            {
                audio_sound_gain(global.bgm, 1, 0);
                soundPlayOL(global.bgm, 100, 1, 1, "music");
            }
        }
        else
        {
            global.firstLand = 1;
            
            if (audio_is_playing(sfxFalling))
                audio_stop_sound(sfxFalling);
            
            if (audio_is_playing(global.bgm))
                audio_stop_sound(global.bgm);
            
            if (global.bgm != global.areaBgm[global.area])
                global.bgm = global.areaBgm[global.area];
        }
    }
}
