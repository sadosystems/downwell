instance_create(0, 0, objTransDither);
alarm[1] = 90;

if (audio_is_playing(whoosh))
    audio_sound_gain(whoosh, 0, 1500);
