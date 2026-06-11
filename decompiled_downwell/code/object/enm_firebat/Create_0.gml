event_inherited();
fPartAmt = 4;

for (i = 0; i <= fPartAmt; i += 1)
{
    fPart[i][0] = x;
    fPart[i][1] = y;
    fPart[i][2] = 0 + (i / 2);
    fPart[i][3] = 0.3;
    fPart[i][4] = -0.2;
    fPart[i][5] = 0.2;
}

ehp = 20;
xsp = 0;
ysp = 0;
vel = random_range(1, 1.5);
xx = x;
yy = y;
movesp = 0.8;
maxsp = 0.8;
acclamt = 0.05;
dcclamt = 0.025;
moyacone = 20;
rotatesp = 10;
direction = irandom(359);
money = 10;

if (place_meeting(x, y - 16, parentWall))
    active = 0;
else
    active = 1;

imgSp = 0.2;
image_speed = imgSp;
