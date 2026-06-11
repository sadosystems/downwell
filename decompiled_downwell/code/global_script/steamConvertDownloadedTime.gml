function steamConvertDownloadedTime(arg0)
{
    milliseconds = arg0;
    
    if (milliseconds < 60000)
    {
        gameTimeInt = floor(milliseconds / 1000);
        gameTimeMin = "00";
        gameTimeSec = gameTimeInt;
        gameTimeDec = floor(((milliseconds / 1000) - gameTimeInt) * 100);
        
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
        gameTimeInt = floor(milliseconds / 1000);
        gameTimeMin = floor(gameTimeInt / 60);
        gameTimeSec = floor(gameTimeInt - (gameTimeMin * 60));
        gameTimeDec = floor(((milliseconds / 1000) - gameTimeInt) * 100);
        
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
    return timeString;
}
