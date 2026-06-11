function drawSpriteHP(arg0, arg1, arg2)
{
    smalx = arg0 - 4;
    smaly = arg1 - 5;
    smalnumb = arg2;
    HPstleng = string_length(string(global.playerHp));
    HPmaxstlegn = string_length(string(global.playerHpMax));
    digits = HPstleng - 1;
    HPx = smalx - (HPstleng * 8) - 1;
    
    for (i = 0; i <= digits; i += 1)
        numb[i] = 0;
    
    for (i = 0; i < HPstleng; i += 1)
        numb[digits - i] = real(string_char_at(string(global.playerHp), HPstleng - i));
    
    for (i = 0; i <= digits; i += 1)
    {
        draw_sprite(sprSpriteNumber, numb[i] + 20, HPx + (i * 8) + 1, smaly);
        draw_sprite(sprSpriteNumber, numb[i] + 20, HPx + (i * 8) + 1, smaly + 1);
        draw_sprite(sprSpriteNumber, numb[i] + 20, HPx + (i * 8), smaly + 1);
        draw_sprite(sprSpriteNumber, numb[i], HPx + (i * 8), smaly);
    }
    
    draw_sprite(sprSpriteSlash, 2, smalx + 1, smaly);
    draw_sprite(sprSpriteSlash, 2, smalx + 1, smaly + 1);
    draw_sprite(sprSpriteSlash, 2, smalx, smaly + 1);
    draw_sprite(sprSpriteSlash, 0, smalx, smaly);
    digits = HPmaxstlegn - 1;
    HPmaxx = smalx + 8 + 1;
    
    for (i = 0; i <= digits; i += 1)
        numb[i] = 0;
    
    for (i = 0; i < HPmaxstlegn; i += 1)
        numb[digits - i] = real(string_char_at(string(global.playerHpMax), HPmaxstlegn - i));
    
    for (i = 0; i <= digits; i += 1)
    {
        draw_sprite(sprSpriteNumber, numb[i] + 20, HPmaxx + (i * 8) + 1, smaly);
        draw_sprite(sprSpriteNumber, numb[i] + 20, HPmaxx + (i * 8) + 1, smaly + 1);
        draw_sprite(sprSpriteNumber, numb[i] + 20, HPmaxx + (i * 8), smaly + 1);
        draw_sprite(sprSpriteNumber, numb[i], HPmaxx + (i * 8), smaly);
    }
}
