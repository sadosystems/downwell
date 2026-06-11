if (!yall && !selected)
{
    if (global.dRightPressed)
    {
        if (cursorAt < styleMax)
        {
            cursorAt += 1;
            soundPlayOL(331, 90, 0, 1, "UI");
        }
        else
        {
            smoothx += 4;
            soundPlayOL(333, 90, 0, 1, "UI");
        }
        
        styleUpdate(cursorAt);
    }
    
    if (global.dLeftPressed)
    {
        if (cursorAt > 0)
        {
            cursorAt -= 1;
            soundPlayOL(331, 90, 0, 1, "UI");
        }
        else
        {
            smoothx -= 4;
            
            if (global.hardUnlocked)
                global.hardMode *= -1;
            
            if (global.hardMode)
            {
                time = 0;
                soundPlayOL(320, 90, 0, 1, "UI");
                scrSmokefxAngle((vx + 80 + (-1 * hardApart)) - smoothx, screenCenter_y - 14, 6, 2, 180, 90);
            }
            else
            {
                if (audio_is_playing(sfxUiHard_Mode_Activate))
                    audio_stop_sound(sfxUiHard_Mode_Activate);
                
                soundPlayOL(333, 90, 0, 1, "UI");
            }
        }
        
        styleUpdate(cursorAt);
    }
    
    if (global.dUp)
    {
        if (global.styleUnlock >= cursorAt)
        {
            global.playStyle = cursorAt;
            emitMovingFx(vx + 80, screenCenter_y - 14, 118, 0.7, 0, 0);
            selected = 1;
            ini_open("save.ini");
            ini_write_real("stats", "style", global.playStyle);
            ini_close();
            ini_open("save.ini");
            ini_write_real("option", "hardMode", global.hardMode);
            ini_close();
            soundPlayOL(332, 90, 0, 1, "UI");
        }
    }
}
else
{
}
