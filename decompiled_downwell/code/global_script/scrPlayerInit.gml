function scrPlayerInit()
{
    activatey = 0;
    emptyText = langString("gunEmpty");
    global.firstLand = 0;
    napping = 0;
    
    if (groundRoom())
    {
        napping = 1;
        groundPlayerSet();
        styleUpdate(global.playStyle);
    }
    
    if (global.area != 0)
        loadCheck();
    
    jetpacksnd = -1;
    oxyGetStun = 0;
    noDraw = 0;
    flickerTime = 0;
    flickerAt = 45;
    flickerDur = 6;
    flick = 0;
    atPit = 0;
    jetpacking = 0;
    jetFrame = 0;
    jetMax = 90;
    onEdge = 0;
    global.achNoDamage = 1;
    global.achNoLand = 1;
    global.achNoSideroom = 1;
    global.achNoKill = 1;
    global.achNoShot = 1;
    global.achAreaNoDamage = 1;
    global.achAreaNoLand = 1;
    forceSkip = 0;
    wallKickLength = 3;
    shootLeg = -1;
    
    if (global.pugLasersight)
        shootLeg = 0;
    
    if (global.pugDecoy)
        instance_create(x, y, decoyBalloon);
    
    if (room == rmMain)
    {
        if (global.level == 1)
        {
            if (global.bgm != 193)
                audio_stop_sound(global.bgm);
        }
        else
        {
            objControlerN.alarm[2] = 60;
        }
    }
    
    pinchEmitTimer = 10;
    alarm[5] = pinchEmitTimer;
    
    if (global.hardMode)
        global.oxygenDepRate = 7;
    else
        global.oxygenDepRate = 13;
    
    alarm[9] = global.oxygenDepRate;
    alarm[8] = 60;
    breath = 0;
    breathTimer = 120;
    tinyJumpThreshold = 0;
    goalStop = 0;
    global.gemStreakTimer = global.gemStreakTimerStart + 120;
    global.puDepletionRate = 0;
    inked = 0;
    xx = x;
    yy = y;
    global.gemGet = 0;
    gemGetText = 0;
    gemLeaking = 0;
    global.oxygen = global.oxygenMax;
    
    with (objControlerN)
    {
        powerUpMem = global.oxygen;
        meterGained = 0;
    }
    
    afterImageOn = 1;
    
    if (afterImageOn)
    {
        afterImageNumber = 8;
        
        for (i = 0; i <= afterImageNumber; i += 1)
        {
            afterImage[i][0] = 31;
            afterImage[i][1] = 0;
            afterImage[i][2] = 1;
            afterImage[i][3] = x;
            afterImage[i][4] = y;
        }
        
        afterImageInterval = 1;
        alarm[7] = afterImageInterval;
    }
    
    global.heartGoal = 0;
    checkStop = 0;
    gemTextFlash = -1;
    xx = round(x);
    yy = round(y);
    xsp = 0;
    ysp = 0;
    xspCarry = 0;
    yspCarry = 0;
    xspFinal = 0;
    yspFinal = 0;
    moveaccl = 0.2;
    maxsp = 2;
    airMaxsp = 2.5;
    waterMaxsp = 2;
    waterAirMaxsp = 2.3;
    decclsp = 0.4;
    jumpsp = 4.4;
    
    if (global.pugRocket)
        jumpsp = 5;
    
    if (global.playStyle == 3)
        jumpsp *= 0.85;
    
    wallkicksp = 4;
    jumpspWater = 3.8;
    airaccl = 1.2;
    airdeccl = 0.1;
    aimAngle = 0;
    global.droneNum = 0;
    global.ballooning = 0;
    global.playerDamaged = 0;
    global.stammo = global.ammo;
    atk = 1;
    burstCount = 0;
    grounded = 0;
    hardLandSp = 1.2;
    hardLand = 0;
    hardLandJump = 0;
    airstatus = 1;
    wet = 0;
    jumpShootLock = 1;
    alarm[5] = 30;
    noChargeMsg = 0;
    airborneShot = 0;
    image_xscale = global.plxDir;
    shotDelay = 1;
    alarm[2] = 30;
    nonAuto = 0;
    wallColliding = 0;
    againstWall = 0;
    inWater = 0;
    outofwaterBoost = 0;
    deathani = 0;
    prvdeath = 0;
    fjump = 0;
    secondjump = 0;
    enemybounce = 2.7;
    prvfallsp = 0;
    messySecondJump = 0;
    image_speed = 0.3;
    dFlash = -1;
    
    if (global.pugDrone)
    {
        instance_create(x, y, objDrone);
        global.droneNum = 1;
        
        if (global.pugDrone == 2)
        {
            with (instance_create(x, y, objDrone))
            {
                xdir = 180;
                ydir = 180;
            }
        }
    }
    
    spriteIdle = 31;
    spriteRun = 27;
    spriteAir = 37;
    spriteSpin = 1;
    spriteShoot = 3;
    spriteYay = 10;
    mask_index = sprPlayerIdle;
    global.playerSprite = sprite_index;
    global.playerImageSpeed = image_speed;
    global.playerImageIndex = image_index;
    imgsprun = 0.3;
    imgspstand = 0.1;
    imgspspin = 0.3;
    imgspshoot = 0.25;
    styleSet();
}
