if (destroyed)
{
    if (!opened)
    {
        opened = 1;
        soundPlay(10, 50, 0, 1);
        image_index = 2;
        mask_index = noMask;
        scrFlashballfx(x, y, 3, 0, 5);
        
        if (storedItem)
            global.criminal = 1;
    }
}
else if (prvWallHp >= (wallHp + 5) && !destroyed && !flashing)
{
}
