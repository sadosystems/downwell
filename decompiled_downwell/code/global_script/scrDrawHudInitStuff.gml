function scrDrawHudInitStuff()
{
    currencyStreakMeterImageIndex = 0;
    powerUpMem = 0;
    meterGained = 0;
    gemhighFrame = 0;
    oxygenBlink = 0;
    hudAmmoJiggle = 0;
    meterJiggle = 0;
    chargeFrameMax = sprite_get_number(sprHudBigCharge) - 1;
    meterLengthMax = 123;
    
    if (global.disp4x3)
        meterLengthMax = 184;
    
    meterLength = meterLengthMax;
    cbl = 1;
    
    for (i = 0; i <= 184; i += 1)
        chargeFrame[i] = chargeFrameMax;
    
    if (global.disp4x3)
    {
        for (i = 0; i <= meterLength; i += 1)
            chargeFrame[i] = 3;
    }
    
    gemStreakShow = 1;
    gemStreakAscend = 0;
    time = 0;
    gemLine = 0;
    gemLineActual = 0;
    barHighlightAmt = 0;
    hla = -4;
}
