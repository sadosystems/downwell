if (y < (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)))
    ysp += global.grav;

if (collisionOn)
{
    scrCheckCollisionWith(56);
    
    if (ycollision == 1)
        ysp = 0;
}

xx += xsp;
yy += ysp;
roundPosition();

if (global.pugEngineer)
{
    if (objHp <= 0)
    {
        scrSmokefx(xx, yy, 1, 0);
        scrFlashballfx(xx, yy, 1, 0, 0);
        obtainable = 0;
        alarm[0] = 30;
        ysp = -2;
        moduleType = choose(0, 1);
        
        if (moduleType == 1)
            sprite_index = sprModHeart;
        else
            sprite_index = sprModBtry;
        
        while (true)
        {
            reverse = irandom(global.bulletMaxNum);
            
            if (reverse != moduleNum)
                break;
        }
        
        moduleNum = reverse;
        moduleImage = global.bStatGunSprite[moduleNum];
        objHp = 9999;
    }
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
