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

if (global.dRightPressed)
{
    cursorAt += 1;
    powan = 0;
    powanx = 1;
}

if (global.dLeftPressed)
{
    cursorAt -= 1;
    powan = 0;
    powanx = 1;
}

if (cursorAt > maxMenu)
    cursorAt = 0;

if (cursorAt < 0)
    cursorAt = maxMenu;

if (rs[6][0])
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
        else if (sequenceOver)
        {
            if (cursorAt == 0)
            {
                if (drawStuff)
                {
                    drawStuff = 0;
                    alarm[2] = 120;
                }
            }
        }
        else if (hardUnlockNotif == 2)
        {
            hardUnlockNotif = 0;
        }
    }
}
