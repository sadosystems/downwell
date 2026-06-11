if (obtainable)
{
    if (itemType == 1)
    {
        scrGainUg(101);
        soundPlay(28, 80, 0, 1);
    }
    else
    {
        scrGainUg(100);
    }
    
    instance_destroy();
}
