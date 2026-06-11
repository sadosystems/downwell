function drawSpriteAmmoNumber(arg0, arg1, arg2)
{
    smalx = arg0;
    smaly = arg1;
    smalnumb = arg2;
    stleng = string_length(string(smalnumb));
    digits = stleng - 1;
    numberx = smalx - (digits * 4);
    
    for (i = 0; i <= digits; i += 1)
        numb[i] = 0;
    
    for (i = 0; i < stleng; i += 1)
        numb[digits - i] = real(string_char_at(string(smalnumb), stleng - i));
    
    for (i = 0; i <= digits; i += 1)
    {
        draw_sprite(sprSpriteNumber, numb[i] + 20, (numberx + (i * 8)) - 1, smaly + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8), (smaly - 1) + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8) + 1, smaly + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8), smaly + 1 + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, (numberx + (i * 8)) - 1, smaly + 1 + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8), (smaly - 1) + 1 + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8) + 1, smaly + 1 + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8), smaly + 1 + 1 + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, ((numberx + (i * 8)) - 1) + 1, smaly + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8) + 1, (smaly - 1) + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8) + 1 + 1, smaly + i);
        draw_sprite(sprSpriteNumber, numb[i] + 20, numberx + (i * 8) + 1, smaly + 1 + i);
        draw_sprite(sprSpriteNumber, numb[i] + 10, numberx + (i * 8), smaly + 1 + i);
        draw_sprite(sprSpriteNumber, numb[i] + 10, numberx + (i * 8) + 1, smaly + i);
    }
    
    for (i = 0; i <= digits; i += 1)
        draw_sprite(sprSpriteNumber, numb[i], numberx + (i * 8), smaly + i);
}
