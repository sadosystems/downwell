if (m_showingTrophy >= 0)
{
    m_notificationY += m_notificationYSpeed;
    
    if (m_notificationYSpeed > 0)
    {
        if (m_notificationY >= 24)
            m_notificationY = 24;
        else if (m_notificationY > 0)
            m_notificationYSpeed = 3;
        else if (m_notificationY > 12)
            m_notificationYSpeed = 4;
    }
    else if (m_notificationYSpeed < 0)
    {
        if (m_notificationY <= -20)
        {
            m_notificationY = -20;
            m_notificationYSpeed = 0;
            alarm[1] = 30;
        }
        else if (m_notificationY < 12)
        {
            m_notificationYSpeed = -6;
        }
    }
    
    if (alarm[0] == 120)
        soundPlayOL(17, 90, 0, 1, "UI");
}
else if (global.g_trophyNotified != global.g_trophyUnlocked)
{
    for (var i = 0; i < UnknownEnum.Value_23; i++)
    {
        var bitToCheck = 1 << i;
        
        if ((global.g_trophyNotified & bitToCheck) == 0)
        {
            if ((global.g_trophyUnlocked & bitToCheck) != 0)
            {
                m_showingTrophy = i;
                global.g_trophyNotified |= bitToCheck;
                m_notificationY = -20;
                m_notificationYSpeed = 2;
                alarm[0] = 180;
                soundPlayOL(336, 90, 0, 1, "UI");
                break;
            }
        }
    }
}

if (global.g_saveDuringGameplayThisFrame)
{
    ini_open("save.ini");
    ini_write_real("trophy", "trophyFlag", global.g_trophyUnlocked);
    ini_write_real("stats", "recordMaxCombo", global.recordMaxCombo);
    ini_close();
    global.g_saveDuringGameplayThisFrame = false;
}

enum UnknownEnum
{
    Value_23 = 23
}
