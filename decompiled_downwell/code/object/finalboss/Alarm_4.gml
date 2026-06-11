if (y < (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + 16))
{
    if (state == 2)
    {
        state = 0;
        soundPlayOL(209, 80, 0, 1, "boss");
        momentDelay();
        scrSShake(16, 8);
        bulAngle = point_direction(x, y, global.plx, global.ply) + random_range(-5, 5);
        myBul = instance_create(x, y, bossLargeBullet);
        myBul.ebSpeed = 1.5;
        myBul.ebDir = bulAngle;
        myBul = instance_create(x, y, bossLargeBullet);
        myBul.ebSpeed = 1.5;
        myBul.ebDir = bulAngle + 30;
        myBul = instance_create(x, y, bossLargeBullet);
        myBul.ebSpeed = 1.5;
        myBul.ebDir = bulAngle - 30;
        
        if (bossShotCount >= bossShotMax)
        {
            alarm[6] = 60 * irandom_range(6, 10);
            alarm[1] = 30;
            bossShotCount = 0;
        }
        else
        {
            alarm[6] = 20;
            bossShotCount += 1;
        }
        
        shotCount = 0;
    }
}
else
{
    alarm[4] = 10;
}

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
