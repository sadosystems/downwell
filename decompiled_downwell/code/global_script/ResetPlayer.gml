function ResetPlayer()
{
    scrInitialize();
    audio_resume_all();
    audio_stop_all();
    soundPlayOL(321, 90, 0, 1, "UI");
    global.area = 0;
    global.level = 0;
    
    with (objControlerN)
    {
        for (i = 0; i <= 6; i += 1)
            alarm[i] = 0;
    }
}
