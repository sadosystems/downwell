if (other.grounded)
{
    if (grounded)
    {
        image_index = 0;
        leapState = 2;
        ysp = jumpsp + random_range(-0.2, 0.2);
        grounded = 0;
        xsp *= choose(1, 1, 1, -1);
    }
    else
    {
        alarm[1] = leapTimer;
    }
}
