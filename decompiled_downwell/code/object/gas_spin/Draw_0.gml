drawShade();

if (!stompa)
{
    inColor = 0;
    outColor = 255;
}
else
{
    inColor = 0;
    outColor = 255;
}

if (hitStun)
{
    if (!stompa)
    {
        inColor = 255;
        outColor = 255;
    }
    else
    {
        inColor = 16777215;
        outColor = 255;
    }
}

for (i = 0; i <= fPartAmt; i += 1)
{
    fpx = round(fPart[i][0]);
    fpy = round(fPart[i][1]);
    fpl = fPart[i][2];
    
    if (fpl < rSize)
    {
        draw_set_color(outColor);
        draw_circle(fpx, fpy, rSize - fpl, 0);
    }
}

if (active)
    draw_self();

for (i = 0; i <= fPartAmt; i += 1)
{
    fpx = round(fPart[i][0]);
    fpy = round(fPart[i][1]);
    fpl = fPart[i][2];
    
    if (fpl < rSize)
    {
        draw_set_color(inColor);
        draw_circle(fpx, fpy, (rSize - fpl) / 1.5, 0);
    }
}
