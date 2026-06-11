scrOutofview();

if (hit && active)
{
    hitStun = 1;
    alarm[0] = 3;
    hit = 0;
    
    if (choose(0, 1))
    {
        myBubble = instance_create(x, y, airBubbleMicro);
        myBubble.xsp = random_range(-1, 1);
    }
}

if (objHp <= 0 && active)
{
    repeat (3)
    {
        myBubble = instance_create(x, y, airBubbleMicro);
        myBubble.xsp = random_range(-1.5, 1.5);
        myBubble.ysp = random_range(-2, -1);
    }
    
    gunshotStop();
    scrSmokefx(x, y, 2, 1);
    scrFlashballfx(x, y, 2, 1, 3);
    soundPlay(183, 85, 0, 1);
    soundPlayOL(309, 85, 0, 1, "waterThings");
    scrCurrencySpawn(2);
    emitSmoke(x + 8, y, 10, 3);
    emitSmoke(x - 8, y, 170, 3);
    bubbleAmt = choose(2, 2, 3);
    
    if (global.oxygen < 50)
        bubbleAmt = choose(2, 3);
    
    if (global.oxygen < 30)
        bubbleAmt = 3;
    
    repeat (bubbleAmt)
        instance_create(x, y, airBubbleS);
    
    active = 0;
}

if (!active)
{
    if (image_index < (image_number - 1))
    {
        image_speed = 0.5;
    }
    else
    {
        image_speed = 0;
        image_index = image_number - 1;
    }
}

if (hitStun)
    sprite_index = hitSprite;
else
    sprite_index = normalSprite;
