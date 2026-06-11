voidAmb = 0;
ambCycle = 191;
tomato = 0;

if (global.area == 5)
{
    if (global.easter)
        tomato = 1;
}

if (tomato)
{
    ambCycle = 200;
    amb = audio_play_sound(ambCycle, 100, 1);
    audio_sound_gain(amb, 0, 0);
    audio_pause_sound(amb);
}
else
{
    amb = -1;
    audio_sound_gain(amb, 0, 0);
}

if (x > (room_width / 2))
    x = room_width - 80;
else
    x = 80;
