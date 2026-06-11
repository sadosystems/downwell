for (i = 1; i <= txtLength; i += 1)
{
    if (i <= txtShown)
    {
        if (txtAt[i][2] < txtFrameMax)
            txtAt[i][2] += 1;
    }
}

alarm[3] = stepSpeed;
