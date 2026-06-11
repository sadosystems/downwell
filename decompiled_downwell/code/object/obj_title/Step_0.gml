if (!objPlayer_n.napping)
{
    if (x > ((__view_get(e__VW.XView, 0) + 80) - 4) && x < (__view_get(e__VW.XView, 0) + 80 + 4))
    {
        if (!global.firstBoot)
        {
            alarm[2] = 15;
            soundPlay(188, 80, 0, 1);
            global.firstBoot = 1;
        }
    }
}

if (global.firstBoot)
{
    if (image_index < (image_number - 1))
    {
        if (choose(0, 1))
        {
            emitMovingFx(x + random_range(-66, 66), y + random_range(-16, 16), choose(655, 656), random_range(0.1, 0.5), 90, 0.1);
            myFx.image_angle = 0;
        }
    }
}

if (image_index > (image_number - 1))
{
    image_speed = 0;
    
    if (!bong)
    {
        alarm[0] = 1;
        bong = 1;
    }
}

y = ystart - (3 * (image_index / (image_number - 1)));

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
