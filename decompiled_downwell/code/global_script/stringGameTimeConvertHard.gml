function stringGameTimeConvertHard()
{
    if (global.recordFastestGameHard < 3600)
    {
        gameTimeInt = floor(global.recordFastestGameHard / 60);
        gameTimeMin = "00";
        gameTimeSec = gameTimeInt;
        gameTimeDec = floor(((global.recordFastestGameHard / 60) - gameTimeInt) * 100);
        
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
        gameTimeInt = floor(global.recordFastestGameHard / 60);
        gameTimeMin = floor(gameTimeInt / 60);
        gameTimeSec = floor(gameTimeInt - (gameTimeMin * 60));
        gameTimeDec = floor(((global.recordFastestGameHard / 60) - gameTimeInt) * 100);
        
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
    
    timeString = gameTimeMin + ":" + gameTimeSec + ":" + gameTimeDec;
    
    if (global.recordFastestGameHard <= 0)
        timeString = " ";
    
    timeDecimalSeconds = (((real(gameTimeMin) * 60) + real(gameTimeSec)) * 100) + real(gameTimeDec);
    
    if (global.isAndroid)
        timeDecimalSeconds *= 10;
    
    return timeString;
}
