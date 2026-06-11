x = room_width / 2;
creditText = scrCreditText();
skipInput = 0;
showSkipText = 0;
meowCount = 0;
creditHeight = 2550;
alarm[1] = 456;
startScroll = 0;
stopScroll = 0;
finalScroll = 0;
yyy = 0;
scrolly = -150;
textLength = string_length(creditText);
inputTextAt = 0;
actualText = "";

while (inputTextAt < textLength)
{
    nexttxt = string_char_at(creditText, inputTextAt + 1);
    currenttxt = string_char_at(creditText, inputTextAt);
    inputTextAt += 1;
    actualText += nexttxt;
}
