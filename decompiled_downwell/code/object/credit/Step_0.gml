yyy -= 0.25;

if (scrolly > -(creditHeight + 160))
{
    if (global.dUp)
    {
        skipInput += 1;
        showSkipText = 1;
        alarm[4] = 60;
        
        if (skipInput >= 9)
        {
            stopScroll = 1;
            parentCamera.endingCamera = 2;
            scrolly = -(creditHeight + 160);
            meowCount = 5;
            
            if (audio_is_playing(bgmCredits))
                audio_stop_sound(bgmCredits);
        }
    }
}

if (scrolly > -creditHeight)
{
    if (startScroll)
        scrolly -= 0.6;
}
else if (!stopScroll)
{
    stopScroll = 1;
    parentCamera.endingCamera = 2;
}

if (!finalScroll)
{
    if (parentCamera.endingCamera == 3)
    {
        finalScroll = 1;
        alarm[0] = 60;
    }
}

if (finalScroll == 2)
{
    scrolly -= 0.6;
    
    if (scrolly < -(creditHeight + 160))
    {
        finalScroll = 3;
        alarm[3] = 270;
    }
}
