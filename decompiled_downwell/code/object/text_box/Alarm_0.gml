nexttxt = string_char_at(textString, inputTextAt + 1);
currenttxt = string_char_at(textString, inputTextAt);

if (nexttxt != "\\" && inputTextAt < textLength)
{
    inputTextAt += 1;
    
    if (nexttxt == global.newline)
    {
        inputTextAt += 1;
        drawText += "#";
    }
    else
    {
        drawText += nexttxt;
    }
    
    alarm[0] = textAmtTimer;
}
else
{
    nextPageOk = 1;
}
