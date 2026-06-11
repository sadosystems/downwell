function comboDone()
{
    if (global.comboCount >= 5)
    {
        instance_create(xx, __view_get(e__VW.YView, 0) + 64 + 64, comboRewardText);
        momentDelay();
        
        if (global.comboCount >= 10)
        {
            steamAchGet(UnknownEnum.Value_4);
            
            if (global.comboCount >= 30)
            {
                steamAchGet(UnknownEnum.Value_5);
                
                if (global.comboCount >= 100)
                    steamAchGet(UnknownEnum.Value_14);
            }
        }
    }
    
    if (global.comboCount > global.highCombo)
        global.highCombo = global.comboCount;
    
    if (global.highCombo > global.recordMaxCombo)
    {
        global.recordMaxCombo = global.highCombo;
        ini_open("save.ini");
        ini_write_real("stats", "recordMaxCombo", global.recordMaxCombo);
        ini_close();
    }
    
    global.comboCount = 0;
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

enum UnknownEnum
{
    Value_4 = 4,
    Value_5,
    Value_14 = 14
}
