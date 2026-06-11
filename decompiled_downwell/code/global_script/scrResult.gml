function scrResult()
{
    if (next == 1)
    {
        if (global.dUp)
        {
            next += 1;
            global.dUp = 0;
            alarm[2] = gemSpawnTimer;
        }
    }
    else if (next == 2)
    {
        if (global.dUp && gemTotal == 0)
        {
            next += 1;
            global.dUp = 0;
            gemSpawnTimer = 1;
            gemSp = 8;
        }
    }
    else if (next == 3)
    {
        if (global.dUp && gemTotal == 0 && heartReceived)
        {
            next += 1;
            global.dUp = 0;
        }
    }
    else if (next == 4)
    {
        if (wasHeartGoal)
        {
            global.playerHp = playerHpMem + 1;
            heartReceived = 1;
            global.heartGoal = 0;
        }
        
        if (global.levelUp)
        {
            if (!showLevelUp)
            {
                showLevelUp = 1;
                circle = 0;
                yPlace = levely + 70;
                plPos = levely + 32;
                plScrollSp = 10;
                yyScrollSp = 10;
                resultRandomizeUg();
                inputWait = 1;
                alarm[3] = waitTime;
            }
        }
        else
        {
            next = 7;
            alarm[0] = 30;
            showLevelUp = 0;
        }
        
        if (showLevelUp)
        {
            if (global.dRightPressed)
            {
                if (cursorAt < levelUgMax)
                {
                    cursorAt += 1;
                    soundPlayOL(338, 90, 0, 1, "UI");
                    time = 0;
                }
            }
            
            if (global.dLeftPressed)
            {
                if (cursorAt > 0)
                {
                    cursorAt -= 1;
                    soundPlayOL(338, 90, 0, 1, "UI");
                    time = 0;
                }
            }
            
            if (global.dUp && !inputWait)
            {
                scrGainUg(levelUg[cursorAt]);
                soundPlayOL(339, 90, 0, 1, "UI");
                scrEffectSpawn(global.plx, global.ply, 113, 0.5, 0, -50500);
                
                if (global.levelUp > 0)
                    global.levelUp -= 1;
                
                if (global.levelUp > 0)
                {
                    cursorAt = 1;
                    resultRandomizeUg();
                }
                else
                {
                    showLevelUp = 0;
                }
                
                global.dUp = 0;
            }
            
            levelUgX = 80 - (ugSprSpace * cursorAt);
            levelUgSmooth += ((levelUgX - levelUgSmooth) / 5);
        }
        
        if (global.dUp)
            global.dUp = 0;
    }
    else if (next >= 7 && gemTotal <= 0 && heartReceived)
    {
        plPos += plPosAccl;
        plPosAccl += 0.2;
    }
    
    global.ply += ((plPos - global.ply) / plScrollSp);
    yy += ((yPlace - yy) / yyScrollSp);
    y = round(yy);
}
