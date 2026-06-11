if (!allSet)
{
    xsp = lengthdir_x(ebSpeed, ebDir);
    ysp = lengthdir_y(ebSpeed, ebDir);
    
    if (imageAngled)
        image_angle = ebDir;
    
    allSet = 1;
}

if (!global.pTimeStop)
{
    for (i = 0; i <= fPartAmt; i += 1)
    {
        if (fPart[i][2] < rSize)
        {
            fPart[i][2] += fPart[i][5];
            fPart[i][0] += fPart[i][3];
            fPart[i][1] += fPart[i][4];
        }
        else if (active)
        {
            fPart[i][2] = 0;
            spRand = 1;
            spRandx = (spRand / random_range(3, 5)) * choose(-1, 1, 0);
            spRandy = spRand - abs(spRandx);
            posRand = random_range(-2, 2);
            fPart[i][0] = x + posRand;
            fPart[i][1] = y + posRand;
            fPart[i][3] = spRandx;
            fPart[i][4] = -spRandy;
            fPart[i][5] = random_range(0.5, 0.7);
        }
        else
        {
            fPart[i][2] = rSize + 1;
        }
    }
    
    xsp = lengthdir_x(ebSpeed, ebDir);
    ysp = lengthdir_y(ebSpeed, ebDir);
    xx += xsp;
    yy += ysp;
    
    if (ebSpeed < maxsp)
        ebSpeed += accl;
    
    if (ebSpeed > maxsp)
        ebSpeed = maxsp;
}

x = round(xx);
y = round(yy);

if (!scrInView(-64, -160, 160))
    instance_destroy();

if (global.bossDead)
    instance_destroy();
