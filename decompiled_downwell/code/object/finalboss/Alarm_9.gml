if (opening == 1)
{
    soundPlayOL(202, 80, 0, 1, "boss");
    opening = 2;
    alarm[9] = alarm[8] + 30;
}
else
{
    opening = 0;
    movesp = 3;
    hit = 0;
    hitStun = 0;
}
