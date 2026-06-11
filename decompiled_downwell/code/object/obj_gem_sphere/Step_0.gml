if (destroyed)
{
    if (!opened)
    {
        opened = 1;
        soundPlay(10, 85, 0, 1);
        image_index = 2;
        mask_index = noMask;
        scrFlashballfx(x, y, 3, 0, 5);
        
        repeat (9)
        {
            myGem = instance_create(x, y, objCurrency);
            
            with (myGem)
            {
                ugrav = 0.045;
                ugravhard = 0.2;
                xsp = random_range(-2, 2);
                ysp = random_range(-4, -1);
                alarm[0] = 20;
                alarm[3] = 60;
                getAmount = 10;
                size = 1;
            }
        }
        
        repeat (10)
        {
            myGem = instance_create(x, y, objCurrency);
            
            with (myGem)
            {
                ugrav = 0.045;
                ugravhard = 0.2;
                xsp = random_range(-2, 2);
                ysp = random_range(-4, -1);
                alarm[0] = 20;
                alarm[3] = 60;
            }
        }
    }
}
else if (prvWallHp >= (wallHp + 10) && !destroyed && !flashing)
{
    image_index = 1;
    alarm[0] = 4;
    flashing = 1;
    soundPlay(12, 50, 0, 1);
    prvWallHp -= 10;
    
    if (prvWallHp <= 0)
        destroyed = 1;
}
