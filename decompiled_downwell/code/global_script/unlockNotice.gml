function unlockNotice(arg0)
{
    unum = arg0 + 1;
    unlockType = 1;
    unlockName = "GBOY";
    unlockSprite = 0;
    
    if (unum == 3 || unum == 7 || unum == 11 || unum == 13)
    {
        switch (unum)
        {
            case 3:
                unlockType = 0;
                unlockName = langString("styleName1");
                unlockSprite = 25;
                break;
            
            case 7:
                unlockType = 0;
                unlockName = langString("styleName2");
                unlockSprite = 26;
                break;
            
            case 11:
                unlockType = 0;
                unlockName = langString("styleName3");
                unlockSprite = 28;
                break;
            
            case 13:
                unlockType = 0;
                unlockName = langString("styleName4");
                unlockSprite = 29;
                break;
        }
    }
    else
    {
        global.shaderArUnlocked += 1;
    }
}
