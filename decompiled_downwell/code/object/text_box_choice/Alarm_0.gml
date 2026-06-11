if (string_char_at(textString, inputTextAt + 1) != "\\" && inputTextAt < textLength)
{
    inputTextAt += 1;
    drawText += string_char_at(textString, inputTextAt);
    alarm[0] = textAmtTimer;
}
else
{
    nextPageOk = 1;
}
