function drawComboNumber(arg0, arg1, arg2)
{
    smalx = arg0;
    smaly = arg1;
    smalnumb = arg2;
    stleng = string_length(string(smalnumb));
    adjx = 0;
    
    if (stleng >= 2)
        adjx -= ((stleng - 1) * 3);
    
    digits = stleng - 1;
    
    for (i = 0; i <= digits; i += 1)
        numb[i] = 0;
    
    for (i = 0; i < stleng; i += 1)
        numb[digits - i] = real(string_char_at(string(smalnumb), stleng - i));
    
    for (i = 0; i <= digits; i += 1)
        draw_sprite(sprComboNumber, numb[i], smalx + (i * 6) + adjx, smaly);
    
    if (global.comboCount >= global.comboMilestone[2])
    {
        draw_sprite(sprComboNumber, 11, smalx - 6, smaly - 6);
        draw_sprite(sprComboNumber, 12, smalx, smaly - 6);
        draw_sprite(sprComboNumber, 13, smalx + 6, smaly - 6);
    }
    else if (global.comboCount >= global.comboMilestone[1])
    {
        draw_sprite(sprComboNumber, 11, smalx - 3, smaly - 6);
        draw_sprite(sprComboNumber, 12, smalx + 3, smaly - 6);
    }
    else if (global.comboCount >= global.comboMilestone[0])
    {
        draw_sprite(sprComboNumber, 11, smalx, smaly - 6);
    }
}
