if (global.dUp)
{
    if (nextPageOk)
    {
        if (inputTextAt < textLength)
        {
            inputTextAt += 3;
            drawText = "";
            nextPageOk = 0;
            textAmtTimer = 1;
            alarm[0] = textAmtTimer;
        }
        else
        {
            if (returnToSender != -1)
                returnToSender.textOver = 1;
            
            instance_destroy();
        }
    }
    else
    {
        while (string_char_at(textString, inputTextAt + 1) != "\\" && inputTextAt < textLength)
        {
            inputTextAt += 1;
            
            if (string_char_at(textString, inputTextAt) == global.newline)
            {
                inputTextAt += 1;
                drawText += "#";
            }
            else
            {
                drawText += string_char_at(textString, inputTextAt);
            }
        }
    }
}
