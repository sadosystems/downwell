function scrSetBuildx()
{
    if (sideRoomGeneration != -1)
    {
        if (!global.wrapMode)
        {
            if (reverseBuild)
                buildx = 160 + (160 - (t * 16));
            else
                buildx = 160 + (t * 16);
        }
        else if (reverseBuild)
        {
            buildx = 144 + (192 - (t * 16));
        }
        else
        {
            buildx = 144 + (t * 16);
        }
    }
    else if (sideRoomGeneration == -1)
    {
        buildx = 0 + (t * 16);
    }
}
