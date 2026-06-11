event_inherited();
ehp = 50;
xsp = 0;
ysp = 0;
vel = random_range(1, 1.5);
rotAmt = random_range(0.2, 2) * choose(1, -1);
rotSwitchAlarm = 60;
alarm[2] = rotSwitchAlarm;
xx = x;
yy = y;
hitStun = 0;
movesp = random_range(0.5, 1);
maxsp = movesp;
acclamt = 0.05;
dcclamt = 0.2;
moyacone = 45;
rotatesp = 4;
ang16 = 22.5;
direction = random(359);
playerDir = direction;
wonder = irandom(359);
money = 10;
active = 1;
emitTimer = 10;
alarm[0] = emitTimer;
imgSp = 0.2;
image_speed = imgSp;
rSize = 10;
fPartAmt = 6;
active = 1;
angry = 0;

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
