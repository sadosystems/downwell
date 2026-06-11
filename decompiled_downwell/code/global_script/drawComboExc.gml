function drawComboExc(arg0, arg1, arg2)
{
    smalx = arg0;
    smaly = arg1;
    smalnumb = arg2;
    stleng = string_length(string(smalnumb));
    adjx = -18;
    
    if (smalnumb >= 10)
        adjx = -21;
    
    digits = stleng - 1;
    
    for (i = 0; i <= digits; i += 1)
        numb[i] = 0;
    
    for (i = 0; i < stleng; i += 1)
        numb[digits - i] = real(string_char_at(string(smalnumb), stleng - i));
    
    for (i = 0; i <= digits; i += 1)
        draw_sprite(sprComboNumber, numb[i], smalx + (i * 6) + adjx, smaly);
    
    draw_sprite(sprComboExc, 0, smalx + (i * 6) + adjx, smaly);
}
