if (grounded)
{
    leapState = 2;
    ysp = jumpsp;
    grounded = 0;
}
else
{
    alarm[1] = 10 + irandom(50);
}
