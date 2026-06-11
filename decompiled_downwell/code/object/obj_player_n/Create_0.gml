scrPlayerInit();
event_inherited();
xsp = 0;
ysp = 0;
time = 0;
instance_create(-100, y, objDepthMeter);
scrSpawnCamera();

if (room == rmMain)
{
    if (global.level == 1)
    {
        if (global.area == 1)
            styleUpdate(global.playStyle);
        
        global.achAreaNoDamage = 1;
        global.achAreaNoLand = 1;
    }
}

if (room == rmMain)
    instance_create(0, 0, objEnterDither);
