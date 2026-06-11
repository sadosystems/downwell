if (global.dUp)
{
    if (!showChoice)
    {
        if (nextPageOk)
        {
            if (inputTextAt < textLength)
            {
                inputTextAt += 1;
                drawText = "";
                nextPageOk = 0;
                textAmtTimer = 1;
                alarm[0] = textAmtTimer;
            }
            else
            {
            }
        }
        else
        {
            while (string_char_at(textString, inputTextAt + 1) != "\\" && inputTextAt < textLength)
            {
                inputTextAt += 1;
                drawText += string_char_at(textString, inputTextAt);
            }
        }
    }
    else if (showChoice)
    {
        returnToSender.choice[decisionNumber] = cursorAt;
        instance_destroy();
    }
}

if (showChoice)
{
    if (global.dRightPressed)
    {
        if (cursorAt < 1)
            cursorAt += 1;
    }
    
    if (global.dLeftPressed)
    {
        if (cursorAt > 0)
            cursorAt -= 1;
    }
}

if (!(inputTextAt < textLength))
{
    if (!showChoice)
        showChoice = 1;
}
