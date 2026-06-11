draw_set_color(c_red);

for (i = 0; i <= fPartAmt; i += 1)
{
    fpx = round(fPart[i][0]);
    fpy = round(fPart[i][1]);
    fpl = fPart[i][2];
    
    if (fpl < rSize)
    {
        if (active)
        {
            draw_set_color(c_red);
            draw_circle(fpx, fpy, rSize - fpl, 0);
        }
        else
        {
            draw_sprite(sprFxSmallSmoke, fpl, fpx, fpy);
        }
    }
}

for (i = 0; i <= fPartAmt; i += 1)
{
    fpx = round(fPart[i][0]);
    fpy = round(fPart[i][1]);
    fpl = fPart[i][2];
    
    if (fpl < rSize)
    {
        if (active)
        {
            draw_set_color(c_black);
            draw_circle(fpx, fpy, (rSize - fpl) / 1.5, 0);
        }
    }
}

draw_self();
