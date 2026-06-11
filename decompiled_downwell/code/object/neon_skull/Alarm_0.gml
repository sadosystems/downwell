if (!global.pTimeStop)
{
    if (angry)
        emitSpr = 704;
    else
        emitSpr = 705;
    
    emitMovingFx(xx, yy, emitSpr, 0.1, 90 + random_range(-20, 20), 0.5);
}

if (angry)
    emitTimer = 8;

alarm[0] = emitTimer;
