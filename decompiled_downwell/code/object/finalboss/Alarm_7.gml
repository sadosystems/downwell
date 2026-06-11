if (!global.death)
{
    if (state == 0)
    {
        randxGrid = 160 + (16 * choose(2, 3, 7, 8));
        randyGrid = myTentacle.y;
        bulAngle = 270;
        myBul = instance_create(randxGrid, randyGrid, enmbul1);
        myBul.ebSpeed = 0.8;
        myBul.ebDir = bulAngle;
        myBul.sprite_index = sprBossTooth;
        myBul.imageAngled = 1;
        soundPlayOL(223, 50, 0, 1, "boss");
        emitMovingFx(randxGrid, __view_get(e__VW.YView, 0), 119, 0.7, 90, 0);
    }
    
    alarm[7] = 150;
    
    if (global.hardMode)
        alarm[7] = 90;
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
