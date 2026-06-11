function steamConvertTimeSubmit()
{
    milliseconds = global.gameTime;
    
    if (milliseconds < 3600)
    {
        gameTimeInt = floor(milliseconds / 60);
        gameTimeMin = "00";
        gameTimeSec = gameTimeInt;
        gameTimeDec = floor(((milliseconds / 60) - gameTimeInt) * 100);
        
        if (gameTimeSec < 10)
            gameTimeSec = "0" + string(gameTimeSec);
        else
            gameTimeSec = string(gameTimeSec);
        
        if (gameTimeDec < 10)
            gameTimeDec = "0" + string(gameTimeDec);
        else
            gameTimeDec = string(gameTimeDec);
    }
    else
    {
        gameTimeInt = floor(milliseconds / 60);
        gameTimeMin = floor(gameTimeInt / 60);
        gameTimeSec = floor(gameTimeInt - (gameTimeMin * 60));
        gameTimeDec = floor(((milliseconds / 60) - gameTimeInt) * 100);
        
        if (gameTimeMin < 10)
            gameTimeMin = "0" + string(gameTimeMin);
        else
            gameTimeMin = string(gameTimeMin);
        
        if (gameTimeSec < 10)
            gameTimeSec = "0" + string(gameTimeSec);
        else
            gameTimeSec = string(gameTimeSec);
        
        if (gameTimeDec < 10)
            gameTimeDec = "0" + string(gameTimeDec);
        else
            gameTimeDec = string(gameTimeDec);
    }
    
    timeDecimalSeconds = (((real(gameTimeMin) * 60) + real(gameTimeSec)) * 100) + real(gameTimeDec);
    timeDecimalSeconds *= 10;
    
    if (!global.hardMode)
    {
        steam_create_leaderboard("FASTEST TIME", lb_sort_ascending, lb_disp_time_ms);
        steam_upload_score("FASTEST TIME", timeDecimalSeconds);
    }
    else
    {
        steam_create_leaderboard("FASTEST TIME HARD", lb_sort_ascending, lb_disp_time_ms);
        steam_upload_score("FASTEST TIME HARD", timeDecimalSeconds);
    }
}
