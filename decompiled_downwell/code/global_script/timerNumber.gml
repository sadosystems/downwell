function timerNumber(arg0, arg1)
{
    smalx = arg0;
    smaly = arg1;
    
    if (global.gameTime < 3600)
    {
        gameTimeInt = floor(global.gameTime / 60);
        gameTimeMin = 0;
        gameTimeSec = gameTimeInt;
        gameTimeDec = floor(((global.gameTime / 60) - gameTimeInt) * 100);
    }
    else
    {
        gameTimeInt = floor(global.gameTime / 60);
        gameTimeMin = floor(gameTimeInt / 60);
        gameTimeSec = floor(gameTimeInt - (gameTimeMin * 60));
        gameTimeDec = floor(((global.gameTime / 60) - gameTimeInt) * 100);
    }
    
    smalnumb = gameTimeDec;
    stleng = string_length(string(smalnumb));
    digits = 1;
    
    for (i = 0; i <= digits; i += 1)
        numb[i] = 0;
    
    if (smalnumb >= 10)
    {
        for (i = 0; i < stleng; i += 1)
            numb[digits - i] = real(string_char_at(string(smalnumb), stleng - i));
    }
    else
    {
        numb[0] = 0;
        numb[digits] = real(string_char_at(string(smalnumb), stleng - i));
    }
    
    for (i = 0; i <= digits; i += 1)
    {
        drawx = (smalx - (6 * digits)) + (i * 6);
        draw_sprite(sprNumbers, numb[i], drawx, smaly);
    }
    
    smalx -= 18;
    draw_sprite(sprNumbers, 11, smalx + 6, smaly);
    smalnumb = gameTimeSec;
    stleng = string_length(string(smalnumb));
    digits = 1;
    
    for (i = 0; i <= digits; i += 1)
        numb[i] = 0;
    
    if (smalnumb >= 10)
    {
        for (i = 0; i < stleng; i += 1)
            numb[digits - i] = real(string_char_at(string(smalnumb), stleng - i));
    }
    else
    {
        numb[0] = 0;
        numb[digits] = real(string_char_at(string(smalnumb), stleng - i));
    }
    
    for (i = 0; i <= digits; i += 1)
    {
        drawx = (smalx - (6 * digits)) + (i * 6);
        draw_sprite(sprNumbers, numb[i], drawx, smaly);
    }
    
    smalx -= 18;
    draw_sprite(sprNumbers, 11, smalx + 6, smaly);
    smalnumb = gameTimeMin;
    stleng = string_length(string(smalnumb));
    digits = 1;
    
    for (i = 0; i <= digits; i += 1)
        numb[i] = 0;
    
    if (smalnumb >= 10)
    {
        for (i = 0; i < stleng; i += 1)
            numb[digits - i] = real(string_char_at(string(smalnumb), stleng - i));
    }
    else
    {
        numb[0] = 0;
        numb[digits] = real(string_char_at(string(smalnumb), stleng - i));
    }
    
    for (i = 0; i <= digits; i += 1)
    {
        drawx = (smalx - (6 * digits)) + (i * 6);
        draw_sprite(sprNumbers, numb[i], drawx, smaly);
    }
}
