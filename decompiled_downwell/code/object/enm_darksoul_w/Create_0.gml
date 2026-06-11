event_inherited();
sprite_index = choose(sprDarksoulEyes1, sprDarksoulEyes2, sprDarksoulEyes3);
ehp = 50;
xsp = 0;
ysp = 0;
vel = random_range(1, 1.5);
xx = x;
yy = y;
hitStun = 0;
movesp = 0.5;
maxsp = 0.5;
acclamt = 0.05;
dcclamt = 0.05;
moyacone = 45;
rotatesp = 4;
ang16 = 22.5;
direction = point_direction(x, y, global.plx, global.ply);
playerDir = direction;
wonder = irandom(359);
money = 10;
active = 1;
emitTimer = 10;
alarm[0] = emitTimer;
imgSp = 0.2;
image_speed = imgSp;
rSize = 10;
fPartAmt = 16;
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
