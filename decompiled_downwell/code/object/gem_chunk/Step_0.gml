if (destroyed)
{
    image_index = 1;
    
    if (!opened)
    {
        opened = 1;
        soundPlay(162, 85, 0, 1);
        sprite_index = sprGemChunkBreak;
        image_index = 1;
        mask_index = noMask;
        emitMovingFx(x, y, 118, 0.7, 0, 0);
        scrFlashballfx(x, y, 3, 0, 5);
        
        if (!global.lowSpec)
        {
            repeat (10)
            {
                myGem = instance_create(x, y, objCurrency);
                
                with (myGem)
                {
                    ugrav = 0.045;
                    ugravhard = 0.2;
                    xsp = random_range(-2.5, 2.5);
                    ysp = random_range(-2, -1);
                    alarm[0] = 20;
                    alarm[3] = 60;
                    getAmount = 10;
                    size = 1;
                }
            }
        }
        else
        {
            repeat (5)
            {
                myGem = instance_create(x, y, objCurrency);
                
                with (myGem)
                {
                    ugrav = 0.045;
                    ugravhard = 0.2;
                    xsp = random_range(-2.5, 2.5);
                    ysp = random_range(-2, -1);
                    alarm[0] = 20;
                    alarm[3] = 60;
                    getAmount = 20;
                    size = 1;
                }
            }
        }
    }
}
else if (prvWallHp >= (wallHp + 3) && !destroyed && !flashing)
{
    sprite_index = sprGemChunkBreak;
    image_index = 0;
    alarm[0] = 4;
    flashing = 1;
    myGem = instance_create(x, y, objCurrency);
    
    with (myGem)
    {
        ugrav = 0.045;
        ugravhard = 0.2;
        xsp = random_range(-2, 2);
        ysp = random_range(-2.5, -1);
        alarm[0] = 20;
        alarm[3] = 60;
    }
    
    soundPlay(161, 50, 0, 1);
    prvWallHp -= 3;
    
    if (prvWallHp <= 0)
        destroyed = 1;
}
