draw_set_color(c_red);

for (i = 0; i <= fPartAmt; i += 1)
{
    fpx = round(fPart[i][0]);
    fpy = round(fPart[i][1]);
    fpl = fPart[i][2];
    
    if (fpl < 8)
    {
        if (active)
            draw_sprite(sprFxFireRed, fpl, fpx, fpy);
        else
            draw_sprite(sprFxSmallSmoke, fpl, fpx, fpy);
    }
}

for (i = 0; i <= fPartAmt; i += 1)
{
    fpx = round(fPart[i][0]);
    fpy = round(fPart[i][1]);
    fpl = fPart[i][2];
    
    if (fpl < 8)
    {
        if (active)
            draw_sprite(sprFxFireWhite, fpl, fpx, fpy);
    }
}
