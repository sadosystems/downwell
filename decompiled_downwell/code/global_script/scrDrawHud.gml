function scrDrawHud()
{
    viewx = __view_get(e__VW.XView, 0);
    vieww = __view_get(e__VW.WView, 0);
    viewy = __view_get(e__VW.YView, 0) + global.g_hudYAdjustment;
    viewh = __view_get(e__VW.HView, 0);
    textxDif = 6;
    hudLifex = viewx + 6;
    hudLifey = viewy + 8;
    hudGemx = viewx + 64;
    hudGemy = viewy + 10;
    hudAmmox = viewx + 8;
    hudAmmoy = viewy + 22;
    hudAmmoTextx = (viewx + vieww) - 16;
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    hpgx = viewx + 1;
    hpgy = viewy + 1;
    hpgLen = 62;
    hpgMeter = hpgLen * (global.playerHp / global.playerHpMax);
    hpgPiece = hpgLen * (global.heartPiece / global.heartPieceMax);
    hpgPieceDiv = hpgLen / global.heartPieceMax;
    draw_sprite(sprHudHpGauge, 1, hpgx, hpgy);
    draw_sprite_stretched(sprRedPixel, 0, hpgx + 4, hpgy + 5, hpgMeter, 6);
    draw_sprite_stretched(sprPixel, 0, hpgx + 4, hpgy + 14, hpgPiece, 2);
    
    for (i = hpgPieceDiv; i < hpgLen; i += hpgPieceDiv)
        draw_sprite(sprHudHpGaugeBar, 2, hpgx + 2 + i, hpgy + 12);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_sprite(sprHudHpGauge, 0, hpgx, hpgy);
    drawShadedText(hpgx + 36, hpgy + 9, string(global.playerHp) + "/" + string(global.playerHpMax), 16777215, 0);
    
    if (abs(global.currencyText - global.currency) > 500)
        curTextAddAmt = 100;
    else if (abs(global.currencyText - global.currency) > 100)
        curTextAddAmt = 10;
    else if (abs(global.currencyText - global.currency) > 50)
        curTextAddAmt = 5;
    else
        curTextAddAmt = 1;
    
    if (global.currencyText > global.currency)
        global.currencyText -= curTextAddAmt;
    else if (global.currencyText < global.currency)
        global.currencyText += curTextAddAmt;
    
    draw_set_halign(fa_center);
    currencyDrawx = viewx + 150;
    currencyDrawy = viewy + 10;
    draw_sprite(sprHudCurrency, 0, currencyDrawx, currencyDrawy);
    draw_set_halign(fa_right);
    scrGemmyText(currencyDrawx - 8, currencyDrawy, string(global.currencyText));
    meterLengthMax = 123;
    meterLength = meterLengthMax;
    gaugeSprite = 373;
    stammoMeter = meterLength * (global.stammo / global.ammo);
    stammoAmmoCon = meterLength * (global.pBulConRate / global.ammo);
    meterDivide = meterLength * (global.pBulConRate / global.ammo);
    meterScale = meterLength * (1 / global.ammo);
    stammoHighlight = meterLength * (barHighlightAmt / global.ammo);
    metery = viewy + 21 + meterJiggle;
    
    if (meterJiggle != 0)
        meterJiggle -= sign(meterJiggle);
    
    draw_set_valign(fa_top);
    draw_sprite(gaugeSprite, 0, viewx, metery);
    chargeMeterx = viewx + 33;
    
    for (i = 0; i < meterLength; i += 1)
    {
        chargeSprite = 379;
        
        if (i < stammoMeter)
        {
            chargeSprite = 379;
            
            if (chargeFrame[i] <= chargeFrameMax)
                chargeFrame[i] += 0.8;
            
            if (i == 0)
            {
                chargeSprite = 381;
                
                if (chargeFrame[i] == 0)
                    chargeFrame[i] = 1;
            }
        }
        else
        {
            chargeSprite = 382;
            
            if (chargeFrame[i] > 1)
                chargeFrame[i] -= 0.8;
        }
        
        if (i >= (stammoMeter - stammoAmmoCon))
            consIndic = 1;
        else
            consIndic = 0;
        
        if (i < stammoHighlight)
            consIndic = hla;
        
        draw_sprite(chargeSprite, chargeFrame[i], chargeMeterx + (i * cbl), metery - 3 - consIndic);
    }
    
    if (global.ammo < 20)
    {
        for (i = meterLength; i > 0; i -= meterScale)
        {
            if (i >= (stammoMeter - stammoAmmoCon))
                consIndic = 1;
            else
                consIndic = 0;
            
            if (i < stammoHighlight)
                consIndic = hla;
            
            if (i < stammoMeter)
                draw_sprite(sprHudBigChargeDivide, 1, chargeMeterx + (i * cbl), metery - 3 - consIndic);
        }
    }
    
    for (i = meterLength; i > 0; i -= meterDivide)
    {
        if (i >= (stammoMeter - stammoAmmoCon))
            consIndic = 1;
        else
            consIndic = 0;
        
        if (i < stammoHighlight)
            consIndic = hla;
        
        if (i < stammoMeter)
        {
            draw_sprite(sprHudBigChargeDivide, 0, chargeMeterx + (i * cbl), metery - 3 - consIndic);
            draw_sprite(sprHudBigChargeDivide, 1, chargeMeterx + (i * cbl) + 1, metery - 3 - consIndic);
            
            if (i == (stammoMeter - stammoAmmoCon))
            {
                if (consIndic == 1)
                    consIndic = 0;
            }
            
            if (i == stammoHighlight)
                consIndic = hla;
            
            draw_sprite(sprHudBigChargeDivide, 1, (chargeMeterx + (i * cbl)) - 1, metery - 3 - consIndic);
        }
        else if (i == stammoMeter || i == 1)
        {
            draw_sprite(sprHudBigChargeDivide, 1, chargeMeterx + (i * cbl), metery - 3 - consIndic);
        }
    }
    
    if (hudAmmoJiggle > 0)
        hudAmmoJiggle -= 1;
    
    if (hudAmmoJiggle < 0)
        hudAmmoJiggle = 0;
    
    if (global.pFired)
        hudAmmoJiggle = 2;
    
    draw_set_halign(fa_center);
    chargeText = string(global.stammo);
    chargeTextx = viewx + 16 + hudAmmoJiggle;
    chargeTexty = metery + 3 + hudAmmoJiggle;
    scrGemmyText(chargeTextx, chargeTexty, chargeText);
    draw_sprite(gaugeSprite, 1, viewx, metery);
    
    if (global.gemStreak > 0 && !global.death)
    {
        gemStreakAscend += ((16 - gemStreakAscend) / 8);
        gemStreakDrawy = round((viewy + 50 + 4) - gemStreakAscend);
        gemStreakDrawx = round(viewx + 81);
        time += 1;
        
        if (global.gemStreakTimer < 120)
        {
            if (!(floor(time) % 2))
                gemStreakShow = 1;
            else
                gemStreakShow = 0;
        }
        else
        {
            gemStreakShow = 1;
        }
        
        if (global.pTimeStop)
        {
            gemStreakShow = 1;
            time = 0;
        }
        else
        {
            gemhighFrame += (0.4 - (0.35 - (0.35 * (global.gemStreakTimer / global.gemStreakTimerStart))));
        }
        
        if (room == rmMain)
        {
            if (gemStreakShow && !global.isPaused)
            {
                gembarii = 7 - (7 * (global.gemStreakTimer / global.gemStreakTimerStart));
                draw_set_halign(fa_center);
                
                if (global.gemStreak >= global.gemStreakThreshold)
                {
                    gemLineActual = round(58 * (global.gemStreakTimer / global.gemStreakTimerStart));
                    
                    if (gemLine < gemLineActual)
                        gemLine += (ceil(gemLineActual - gemLine) / 4);
                    
                    if (gemLine > gemLineActual)
                        gemLine = gemLineActual;
                    
                    for (i = 0; i <= gemLine; i += 1)
                    {
                        draw_sprite(sprGemBar, 4, gemStreakDrawx + i, gemStreakDrawy - 1);
                        draw_sprite(sprGemBar, 4, gemStreakDrawx - i, gemStreakDrawy - 1);
                    }
                    
                    draw_sprite(sprGemBarSr, time, gemStreakDrawx + gemLine, gemStreakDrawy);
                    draw_sprite(sprGemBarSl, time, gemStreakDrawx - gemLine, gemStreakDrawy);
                    
                    if (global.pugLessResist)
                        draw_sprite(sprGemsickMotion, gemhighFrame, gemStreakDrawx, gemStreakDrawy + 4 + 1);
                    else
                        draw_sprite(sprGemhighMotion, gemhighFrame, gemStreakDrawx, gemStreakDrawy + 4 + 1);
                }
                else
                {
                    gemLineActual = round(54 * (global.gemStreak / global.gemStreakThreshold));
                    
                    if (gemLine < gemLineActual)
                        gemLine += (ceil(gemLineActual - gemLine) / 4);
                    
                    if (gemLine > gemLineActual)
                        gemLine = gemLineActual;
                    
                    for (i = 0; i <= gemLine; i += 1)
                    {
                        draw_sprite(sprGemBar, 1, gemStreakDrawx + i, gemStreakDrawy);
                        draw_sprite(sprGemBar, 1, gemStreakDrawx - i, gemStreakDrawy);
                    }
                    
                    draw_sprite(sprGemBar, 0, gemStreakDrawx + gemLine, gemStreakDrawy);
                    draw_sprite(sprGemBar, 2, gemStreakDrawx - gemLine, gemStreakDrawy);
                    gemStreakText = " " + string(global.gemStreak);
                    scrGemmyText(gemStreakDrawx, gemStreakDrawy + 1, gemStreakText);
                    draw_sprite(sprGemS, 0, (gemStreakDrawx - round(string_width(string_hash_to_newline(string(gemStreakText))) / 2)) + 4, gemStreakDrawy + 4 + 1);
                }
            }
        }
    }
    
    if (global.showTimer)
        timerNumber((viewx + 160) - 4, viewy + 40);
    
    if (global.gInWater && !global.isPaused && !global.noControl && !global.deathMenuShow)
    {
        oxyTextx = __view_get(e__VW.XView, 0) + 80 + 5;
        oxyTexty = (__view_get(e__VW.YView, 0) + (__view_get(e__VW.HView, 0) / 2)) - 64 - 8;
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        
        if (!global.hardMode)
        {
            if (global.oxygen < 40)
            {
                if (global.oxygen < 20)
                    oxygenBlink += 0.2;
                else
                    oxygenBlink += 0.1;
            }
            else
            {
                oxygenBlink = 0;
            }
        }
        else if (global.oxygen < 100)
        {
            if (global.oxygen < 0)
                oxygenBlink = 3;
            else
                oxygenBlink += 0.3;
        }
        else
        {
            oxygenBlink = 0;
        }
        
        if ((floor(oxygenBlink) % 2) > 0)
            scrDrawBorderTextRed(oxyTextx, oxyTexty, string(global.oxygen));
        else
            scrDrawBorderTextBlack(oxyTextx, oxyTexty, string(global.oxygen));
        
        draw_sprite(sprBubbleSmall, 0, oxyTextx - 8 - (string_length(string(global.oxygen)) * 4), oxyTexty - 1);
    }
    
    draw_set_halign(fa_left);
    ugShowy = (viewy + viewh) - 8 - global.g_hudYAdjustment;
    
    if (global.ugHave > 0)
    {
        for (i = 1; i <= global.ugHave; i += 1)
        {
            ugShowx = __view_get(e__VW.XView, 0) + 8 + 6 + (12 * (i - 1));
            draw_sprite(global.ug[global.ugOrder[i]][2], 1, ugShowx, ugShowy);
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
