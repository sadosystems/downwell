function resultRandomizeUg()
{
    levelUg[0] = 100;
    levelUg[1] = 100;
    levelUg[2] = 100;
    
    for (i = 0; i <= levelUgMax; i += 1)
    {
        randLoop = 0;
        
        while (true)
        {
            ugRand = irandom(global.ugCount);
            prvCheck = 0;
            
            if (global.ug[ugRand][1] < global.ug[ugRand][4])
            {
                if (i > 0)
                {
                    t = i - 1;
                    
                    while (t >= 0)
                    {
                        if (ugRand == levelUg[t])
                            prvCheck += 1;
                        
                        t -= 1;
                    }
                    
                    if (prvCheck == 0)
                    {
                        levelUg[i] = ugRand;
                        break;
                    }
                }
                else
                {
                    levelUg[i] = ugRand;
                    break;
                }
            }
            
            randLoop += 1;
            
            if (randLoop > 60)
                break;
        }
    }
    
    for (i = 0; i <= levelUgMax; i += 1)
    {
        ugNameText[i] = langString("ugName" + string(levelUg[i]));
        ugDescText[i] = langString("ugDesc" + string(levelUg[i]));
    }
}
