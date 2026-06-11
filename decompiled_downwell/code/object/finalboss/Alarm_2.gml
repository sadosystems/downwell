if (audio_is_playing(myRumble))
{
    audio_stop_sound(myRumble);
    myRumble = -1;
}

state = 0;
soundPlayOL(210, 50, 0, 1, "boss");
scrSShake(6, 15);

if (!alarm[1])
    alarm[1] = 30;

if (opening)
{
    growlShake = 5;
    yy -= 16;
}
