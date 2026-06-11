if (size == 0)
{
    sprite_index = sprGemS;
    
    if (mask_index != sprite_index)
        mask_index = sprite_index;
}
else if (size == 1)
{
    sprite_index = sprGemM;
    
    if (mask_index != sprite_index)
        mask_index = sprite_index;
}

if (!dflash)
    drawFx();
