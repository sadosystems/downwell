event_inherited();
fPartAmt = 8;
objHp = 1;
active = 1;
stomped = 0;

for (i = 0; i <= fPartAmt; i += 1)
{
    fPart[i][0] = x;
    fPart[i][1] = y;
    fPart[i][2] = 0 + (i / 2);
    fPart[i][3] = 0.3;
    fPart[i][4] = -0.2;
    fPart[i][5] = 0.2;
}
