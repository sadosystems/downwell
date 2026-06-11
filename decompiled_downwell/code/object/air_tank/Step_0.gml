if (hit)
{
    hit = 0;
    hitStun = 1;
    alarm[1] = 5;
}

if (wallHp <= 0)
{
    soundPlay(breakSound, 50, 0, 1);
    scrSmokefx(x, y + 4, 1, 0);
    scrFlashballfx(x, y, 1, 0, 2);
    
    repeat (2)
        instance_create(x, y - 30, breakablesDebris);
    
    bubbleAmt = 3;
    
    if (global.hardMode)
        bubbleAmt = 6;
    
    instance_destroy();
    
    repeat (bubbleAmt)
        instance_create(x, y, airBubbleS);
}

if (hitStun)
    image_index = 1;
else
    image_index = 0;

alarmStop(0);
