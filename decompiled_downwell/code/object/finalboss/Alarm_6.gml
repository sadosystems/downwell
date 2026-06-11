if (state == 0)
{
    if (bossShotCount == 0)
    {
        movesp = 2.5;
        scrSShake(4, 10);
        soundPlayOL(204, 80, 0, 1, "boss");
        state = 2;
        image_index = 0;
        alarm[4] = 90;
    }
    else
    {
        alarm[4] = 20;
        movesp = 1.5;
        scrSShake(4, 10);
        soundPlayOL(204, 80, 0, 1, "boss");
        state = 2;
        image_index = 0;
    }
}

alarm[6] = 60 * irandom_range(4, 8);
