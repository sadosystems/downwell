function stringGameTimeConvert()
{
    if (global.recordFastestGame < 3600)
    {
        gameTimeInt = floor(global.recordFastestGame / 60);
        gameTimeMin = "00";
        gameTimeSec = gameTimeInt;
        gameTimeDec = floor(((global.recordFastestGame / 60) - gameTimeInt) * 100);
        
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
        gameTimeInt = floor(global.recordFastestGame / 60);
        gameTimeMin = floor(gameTimeInt / 60);
        gameTimeSec = floor(gameTimeInt - (gameTimeMin * 60));
        gameTimeDec = floor(((global.recordFastestGame / 60) - gameTimeInt) * 100);
        
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
    
    if (global.recordFastestGame <= 0)
        timeString = "NO RECORD";
    
    timeDecimalSeconds = (((real(gameTimeMin) * 60) + real(gameTimeSec)) * 100) + real(gameTimeDec);
    
    if (global.isAndroid)
        timeDecimalSeconds *= 10;
    
    return timeString;
}
