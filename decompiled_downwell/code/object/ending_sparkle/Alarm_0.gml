emitMovingFx(__view_get(e__VW.XView, 0) + 80 + random_range(-70, 70), __view_get(e__VW.YView, 0) + global.g_cameraHeight + random_range(-16, 32), choose(655, 656), random_range(0.05, 0.2), 90, random_range(0.05, 1));
myFx.image_angle = 0;
alarm[0] = sparkleTimer;

if (parentCamera.endingCamera == 2)
{
    if (sparkleTimer < 3)
        sparkleTimer = 3;
    
    sparkleTimer += 1;
}
else
{
    sparkleTimer /= 1.5;
    
    if (sparkleTimer < 3)
        sparkleTimer = 3;
}

if (parentCamera.endingCamera == 3)
    instance_destroy();

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
