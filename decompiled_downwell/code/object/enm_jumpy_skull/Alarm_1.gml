if (grounded)
{
    image_index = 0;
    leapState = 2;
    ysp = jumpsp + random_range(-0.3, 0.3);
    soundPlayOL(jumpySound, 50, 0, 1, "enemymove");
    grounded = 0;
    xsp *= choose(1, 1, 1, -1);
}
else
{
    alarm[1] = leapTimer;
}
