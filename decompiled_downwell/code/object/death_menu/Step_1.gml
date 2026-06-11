if (powan < powanMax)
    powan += 0.4;

wholePowan -= sign(wholePowan);
wholePowan2 -= sign(wholePowan2);
powanx -= sign(powanx);

for (i = 0; i <= resultShown; i += 1)
{
    rs[i][0] = 1;
    
    if (rs[i][1] > 0)
        rs[i][1] -= 1;
}

if (sequenceOver)
{
    if (global.dRightPressed)
    {
        cursorAt += 1;
        powan = 0;
        powanx = 1;
        soundPlayOL(324, 90, 0, 1, "UI");
    }
    
    if (global.dLeftPressed)
    {
        cursorAt -= 1;
        powan = 0;
        powanx = 1;
        soundPlayOL(324, 90, 0, 1, "UI");
    }
    
    if (cursorAt > maxMenu)
        cursorAt = 0;
    
    if (cursorAt < 0)
        cursorAt = maxMenu;
}

if (rs[5][0])
{
    if (global.dUp)
    {
        if (goalPassed)
        {
            if (goalNotif >= 3)
            {
                goalPassed = 0;
                goalNotif = 0;
                gr += 1;
                
                if (gr >= 41)
                    global.unlockMax = 1;
            }
        }
        
        if (sequenceOver && !inputDisable)
        {
            if (cursorAt == 0)
            {
                ResetPlayer();
                scrNextLevel(1);
            }
            
            if (cursorAt == 1)
            {
                ResetPlayer();
                room_goto(rmPlayMenu);
            }
            
            if (cursorAt >= 2)
            {
                ResetPlayer();
                BackToSurface();
            }
        }
    }
    else
    {
    }
}

if (global.dUp)
{
    if (!sequenceOver)
    {
        if (resultShown < rsMax)
            resultShown = rsMax;
        
        inputDisable = 1;
        alarm[2] = 20;
    }
}
