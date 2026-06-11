if (!audio_is_playing(global.voidWind))
{
    windsnd = choose(349, 350, 351, 352, 353, 354, 355);
    global.voidWind = soundPlayOL(windsnd, 90, 0, 1, "UI");
    audio_sound_gain(global.voidWind, 0.5, 0);
}
