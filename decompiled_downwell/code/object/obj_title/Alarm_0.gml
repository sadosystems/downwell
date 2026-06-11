repeat (20)
{
    emitMovingFx(x + random_range(-70, 70), y + random_range(-16, 16), choose(655, 656), random_range(0.035, 0.2), 90, random_range(0.1, 0.2));
    myFx.image_angle = 0;
}

alarm[1] = 75;
