ysp = -5;
showBonusTimer = 10;
alarm[2] = 2;
rewardGems = 0;
showBonus = 0;
showBonusMax = 0;

if (global.comboCount >= global.comboMilestone[0])
{
    showBonusMax = 2;
    soundPlayOL(315, 80, 0, 1, "UI");
    rewardGems = 100;
    nonGemGainGem(rewardGems);
}

if (global.comboCount >= global.comboMilestone[1])
{
    showBonusMax = 3;
    soundPlayOL(316, 80, 0, 1, "UI");
    global.ammo += 1;
    global.stammo = global.ammo;
    scrEffectSpawn(global.plx, global.ply, 111, 1, 0, -50500);
}

if (global.comboCount >= global.comboMilestone[2])
{
    showBonusMax = 4;
    soundPlayOL(317, 80, 0, 1, "UI");
    gainHp(1);
}

alarm[1] = 45 + (15 * showBonusMax) + 45;
alarm[0] = alarm[1] + 15;
flashing = 0;
drawing = 1;
decreaseBy = 0.85;
comboNum = global.comboCount;
powanReward = 4;
powanGem = 4;
powanBtry = 4;
powanHP = 4;
relativex = x - __view_get(e__VW.XView, 0);
relativey = y - ((y - parentCamera.y) / 2);
flashFrame = 0;

if (global.death)
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
