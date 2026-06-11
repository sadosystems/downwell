if (y < 1000)
{
    y += ysp;
}
else if (!blackSet)
{
    blackSet = 1;
    alarm[0] = 5;
}

ysp += 0.25;
myLocker.pointery = y;
