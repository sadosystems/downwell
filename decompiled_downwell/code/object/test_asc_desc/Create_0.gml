with (other)
{
    event_inherited();
    stompa = 1;
    ehp = 10;
    xsp = 0;
    ysp = 0;
    vel = random_range(1, 1.5);
    
    if (y < __view_get(e__VW.YView, 0))
        y = __view_get(e__VW.YView, 0) - (16 * irandom_range(1, 4));
    else
        y = __view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0) + (16 * irandom_range(1, 4));
    
    xx = x;
    yy = y;
    hitStun = 0;
    movesp = 1;
    origMaxsp = random_range(0.5, 1);
    maxsp = origMaxsp;
    acclamt = 0.05;
    dcclamt = 0.25;
    sprite_index = sprDescentSphere;
    moyacone = 10;
    rotatesp = 2;
    
    if (x > (room_width / 2))
        targetdir = irandom_range(90, 135);
    else
        targetdir = irandom_range(45, 90);
    
    targetdir = 90;
    ang16 = 22.5;
    direction = 90;
    playerDir = direction;
    money = 10;
    active = 1;
    emitTimer = 10;
    alarm[0] = emitTimer;
    imgSp = 0.4;
    image_speed = imgSp;
    rSize = 6;
    fPartAmt = 6;
    active = 1;
    
    for (i = 0; i <= fPartAmt; i += 1)
    {
        fPart[i][0] = x;
        fPart[i][1] = y;
        fPart[i][2] = 0 + (i / 2);
        fPart[i][3] = 0.3;
        fPart[i][4] = -0.2;
        fPart[i][5] = 0.2;
    }
    
    tt = 0;
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
