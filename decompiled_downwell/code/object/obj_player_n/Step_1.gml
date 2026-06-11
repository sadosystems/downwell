if ((__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)) > (activatey - 112))
{
    activatey += 16;
    instance_activate_region(0, 0, room_width, activatey, 1);
}

scrGravity_n();
scrCheckInWater();
scrPlMovement();
scrWallCol();

if (napping)
{
    xsp = 0;
    ysp = 0;
    jumpShootLock = 1;
}

if (jetpacking)
{
    if (!jetpacksnd)
        jetpacksnd = soundPlay(343, 80, 1, 1);
}
else
{
    if (audio_is_playing(jetpacksnd))
        audio_stop_sound(jetpacksnd);
    
    jetpacksnd = -1;
}

if (!goalStop)
{
    if (!global.death && global.bossDead != 2)
    {
        if (room == rmMain)
        {
            if (!place_meeting(x, y, goalTimeField))
                global.gameTime += 1;
        }
    }
    
    yy += ysp;
    xx += xsp;
}

if (global.wrapMode)
{
    if (xx > 320)
        xx = 160;
    else if (xx < 160)
        xx = 320;
}

x = round(xx);
y = round(yy);

if (instance_place(xx, yy, camLocker))
    global.pCamFocus = instance_place(xx, yy, camLocker);
else
    global.pCamFocus = -1;

if (place_meeting(xx, yy, parentInteractable) && xsp == 0 && grounded)
{
    if (instance_place(xx, yy, parentInteractable).interactOk)
    {
        if (!global.interactable)
            global.interactable = 1;
    }
    else if (global.interactable)
    {
        global.interactable = 0;
    }
}
else if (global.interactable)
{
    global.interactable = 0;
}

if (room == rmMain || room == rmTutorialMain)
{
    if (place_meeting(xx, yy, parentTimeField) || xx < 160 || xx > (room_width - 160))
    {
        if (!checkStop)
        {
            checkStop = 1;
            
            if (place_meeting(xx, yy, parentTimeField))
            {
                scrTimeShard();
                scrSShake(2, 2);
            }
        }
    }
    else if (checkStop)
    {
        checkStop = 0;
        scrTimeShard();
    }
}
else if (place_meeting(xx, yy, parentTimeField))
{
    if (!checkStop)
        checkStop = 1;
}
else if (checkStop)
{
    checkStop = 0;
}

if (checkStop == 1)
{
    if (!global.pTimeStop)
    {
        global.pTimeStop = 1;
        instance_create(xx, yy, fxTimeChange);
        
        if (audio_is_playing(global.bgm))
            audio_pause_sound(global.bgm);
        
        global.bgmOn = 0;
        scrTimeShard();
        soundPlay(184, 80, 0, 1);
    }
}
else if (checkStop == 0)
{
    if (global.pTimeStop)
    {
        global.pTimeStop = 0;
        instance_create(xx, yy, fxTimeChange);
        
        if (audio_is_paused(global.bgm))
            audio_resume_sound(global.bgm);
        
        if (audio_is_playing(global.voidWind))
            audio_stop_sound(global.voidWind);
        
        global.bgmOn = 1;
        scrTimeShard();
        soundPlay(185, 80, 0, 1);
        bgmDuck(200, 0.7);
    }
}

if (global.pTimeStop)
{
    if (global.oxygen < 10)
        global.oxygen = 10;
}

if (global.playerHp <= 0)
{
    global.death = 1;
    global.playerHp = 0;
    
    if (!prvdeath)
        deathani = 1;
}

if (!alive)
    global.death = 1;

if (image_xscale != 0)
    global.plxDir = sign(image_xscale);

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
