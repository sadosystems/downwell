if (afterImageOn)
{
    for (i = afterImageNumber; i >= 1; i -= 1)
    {
        afterImage[i][0] = afterImage[i - 1][0];
        afterImage[i][1] = afterImage[i - 1][1];
        afterImage[i][2] = afterImage[i - 1][2];
        afterImage[i][3] = afterImage[i - 1][3];
        afterImage[i][4] = afterImage[i - 1][4];
    }
    
    afterImage[0][0] = sprite_index;
    afterImage[0][1] = image_index;
    afterImage[0][2] = image_xscale;
    afterImage[0][3] = x;
    afterImage[0][4] = y;
    alarm[7] = afterImageInterval;
}
