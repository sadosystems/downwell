event_inherited();
normalSpr = sprite_index;
stunSpr = sprite_index;
deadSpr = 229;
ehp = 10;
white = 0;
xsp = 0;
ysp = 0;
vel = random_range(1, 1.5);
angry = 0;
rotAmt = random_range(0.2, 2) * choose(1, -1);
rotSwitchAlarm = 60;
alarm[2] = rotSwitchAlarm;
emitTimer = 30;
alarm[0] = emitTimer;
xx = x;
yy = y;
hitStun = 0;
movesp = random_range(0.5, 1);
maxsp = movesp;
acclamt = 0.05;
dcclamt = 0.05;
moyacone = 45;
rotatesp = 2;
ang16 = 22.5;
direction = random(359);
playerDir = direction;
wonder = irandom(359);
money = 8;
active = 1;
imgSp = 0.2;
image_speed = imgSp;
rSize = 8;
fPartAmt = 8;
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
