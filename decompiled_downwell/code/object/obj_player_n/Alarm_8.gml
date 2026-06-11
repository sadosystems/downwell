if (global.gInWater && !global.death && !goalStop)
{
    instance_create(x, y, airBubbleMicro);
    
    if (breath < 3)
    {
        breath += 1;
        alarm[8] = 5;
    }
    else
    {
        breath = 0;
        
        if (global.oxygen > 40)
        {
            soundPlayOL(306, 80, 0, 1, "waterThings");
            audio_sound_pitch(sndsnd, random_range(0.7, 1));
            alarm[8] = breathTimer;
        }
        else if (global.oxygen > 20)
        {
            soundPlayOL(310, 80, 0, 1, "waterThings");
            alarm[8] = breathTimer / 2;
        }
        else
        {
            soundPlayOL(310, 80, 0, 1, "waterThings");
            audio_sound_pitch(sndsnd, 1.2);
            alarm[8] = breathTimer / 3;
        }
    }
}
else
{
    alarm[8] = breathTimer;
}
