meowCount += 1;

if (meowCount == 1)
{
    distantMeow = soundPlayOL(347, 80, 0, 1, "UI");
    audio_sound_gain(distantMeow, 0.3, 0);
    audio_sound_pitch(distantMeow, 0.85);
    alarm[3] = 210;
}
else if (meowCount == 2)
{
    distantMeow = soundPlayOL(347, 80, 0, 1, "UI");
    audio_sound_gain(distantMeow, 0.6, 0);
    audio_sound_pitch(distantMeow, 0.9);
    alarm[3] = 180;
}
else
{
    with (objBuilder)
        scrBossPatPit();
    
    instance_destroy();
}
