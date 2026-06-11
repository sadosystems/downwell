yPlace = 142;

if (audio_is_playing(global.bgm))
    audio_pause_sound(global.bgm);

if (global.achNoDamage == 1)
    steamAchGet(UnknownEnum.Value_1);

if (global.achNoLand == 1)
    steamAchGet(UnknownEnum.Value_13);

if (global.achNoSideroom == 1)
    steamAchGet(UnknownEnum.Value_2);

if (global.achNoKill == 1)
    steamAchGet(UnknownEnum.Value_12);

if (global.achNoShot == 1)
    steamAchGet(UnknownEnum.Value_3);

if (global.level == 3)
{
    if (!global.hardMode)
    {
        switch (global.area)
        {
            case 1:
                steamAchGet(UnknownEnum.Value_7);
                break;
            
            case 2:
                steamAchGet(UnknownEnum.Value_8);
                break;
            
            case 3:
                steamAchGet(UnknownEnum.Value_9);
                break;
            
            case 4:
                steamAchGet(UnknownEnum.Value_10);
                break;
        }
    }
    else
    {
        switch (global.area)
        {
            case 1:
                steamAchGet(UnknownEnum.Value_17);
                break;
            
            case 2:
                steamAchGet(UnknownEnum.Value_18);
                break;
            
            case 3:
                steamAchGet(UnknownEnum.Value_19);
                break;
            
            case 4:
                steamAchGet(UnknownEnum.Value_20);
                break;
        }
    }
}

alarm[4] = 60;
global.gemStreakTimer = global.gemStreakTimerStart;

if (global.area != 3)
    whoosh = soundPlayOL(186, 80, 1, 1, "UI");
else
    whoosh = -1;

if (audio_is_playing(whoosh))
{
    audio_sound_gain(whoosh, 0, 0);
    audio_sound_gain(whoosh, 1, 1000);
}

if (global.level == 3)
    loadingGroup = loadForArea(global.area + 1);

yy = yPlace;
y = round(yy);
tiley = 0;
global.pTimeStop = 1;
global.plx = 80;
global.ply = 0;
plPos = 160;
global.stammo = global.ammo;
next = 0;
plPosAccl = 0;
plScrollSp = 20;
yyScrollSp = 10;
gemSp = random_range(1, 4);
playerHpMem = global.playerHp;
playerHpMaxMem = global.playerHpMax;
showLevelUp = 0;

if (global.heartGoal)
{
    wasHeartGoal = 1;
    heartReceived = 0;
}
else
{
    wasHeartGoal = 0;
    heartReceived = 1;
}

inputWait = 1;
waitTime = 30;
global.levelUp = 1;

if (global.playStyle == 4)
    global.levelUp = 0;

global.gemGet = 0;
gemGetMem = global.gemGet;
gemTotal = global.gemGet;
currencyTotal = global.currency + gemTotal;
gemSpawnTimer = 2;
showBonus = 0;
showHeart = 0;
bordery = 36;
tileMaxy = 36;
time = 0;
bounceAmt = global.gemGet / 50;

if (bounceAmt > 32)
    bounceAmt = 32;

bonusx = 80;
bonusy = 96;
heartx = 80;
hearty = 136;
levelx = 80;
levely = 270;
ugdescy = levely + 40;
lenx = 0;
circle = 0;
levelUg[0] = 0;
levelUg[1] = 0;
levelUg[2] = 0;
levelUg[3] = 0;
levelUgMax = 2 + global.pugYouth;

if (global.playStyle == 2)
    levelUgMax -= 1;

ugSprSpace = 38;
levelUgX = 80;
levelUgSmooth = 80;
cursorAt = floor(levelUgMax / 2);
levelUgX = 80 - (ugSprSpace * cursorAt);
levelUgSmooth = levelUgX;
ugNameText[0] = "-";
ugDescText[0] = "-";
ugNameText[1] = "-";
ugDescText[1] = "-";
ugNameText[2] = "-";
ugDescText[2] = "-";
ugNameText[3] = "-";
ugDescText[3] = "-";
cleartext = langString("transitionCleared");
chooseText = langString("transitionChoose");

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_7 = 7,
    Value_8,
    Value_9,
    Value_10,
    Value_12 = 12,
    Value_13,
    Value_17 = 17,
    Value_18,
    Value_19,
    Value_20
}
