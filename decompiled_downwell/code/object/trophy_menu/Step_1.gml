if (powan < powanMax)
    powan += 0.4;

wholePowan -= sign(wholePowan);
wholePowan2 -= sign(wholePowan2);

if (global.pauseInput || !global.isPaused)
{
    instance_destroy();
    
    if (!global.pTimeStop)
    {
        if (audio_is_paused(global.bgm))
            audio_resume_sound(global.bgm);
    }
}
else if (global.dLeftPressed)
{
    displayedTrophy--;
    
    if (displayedTrophy < 0)
        displayedTrophy = 22;
    
    soundPlayOL(324, 90, 0, 1, "UI");
}
else if (global.dRightPressed)
{
    displayedTrophy++;
    
    if (displayedTrophy >= UnknownEnum.Value_23)
        displayedTrophy = 0;
    
    soundPlayOL(324, 90, 0, 1, "UI");
}
else if (global.dUp || global.padCancel)
{
    with (instance_create(0, 0, RecordMenu))
        cursorAt = 0;
    
    instance_destroy();
    soundPlayOL(322, 90, 0, 1, "UI");
    global.padCancel = 0;
}

enum UnknownEnum
{
    Value_23 = 23
}
