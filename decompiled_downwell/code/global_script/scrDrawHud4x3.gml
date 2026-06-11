function scrDrawHud4x3()
{
    viewx = 0;
    vieww = 0;
    viewy = 0;
    viewh = 0;
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
    hpgx = (viewx + -64) - 38;
    hpgy = viewy + 6;
    hpgLen = 80;
    hpgMeter = hpgLen * (global.playerHp / global.playerHpMax);
    hpgPiece = hpgLen * (global.heartPiece / global.heartPieceMax);
    hpgPieceDiv = hpgLen / global.heartPieceMax;
    draw_sprite(sprPcHudHpGauge, 1, hpgx, hpgy);
    draw_sprite_stretched(sprRedPixel, 0, hpgx + 4, hpgy + 5, hpgMeter, 6);
    draw_sprite_stretched(sprPixel, 0, hpgx + 4, hpgy + 14, hpgPiece, 2);
    
    for (i = hpgPieceDiv; i < hpgLen; i += hpgPieceDiv)
        draw_sprite(sprHudHpGaugeBar, 2, hpgx + 2 + i, hpgy + 12);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_sprite(sprPcHudHpGauge, 0, hpgx, hpgy);
    drawSpriteHP(hpgx + 36 + 8, hpgy + 9, 0);
    
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
    currencyDrawx = (viewx + 160 + 64 + 38) - 10;
    currencyDrawy = viewy + 10 + 8;
    draw_sprite(sprHudCurrency, 0, currencyDrawx, currencyDrawy);
    draw_set_halign(fa_right);
    drawSpriteGemNumber(currencyDrawx - 8, currencyDrawy, global.currencyText);
    meterLengthMax = 184;
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
    chargeMeterx = 174;
    chargeMetery = 229 + (meterJiggle * 4);
    draw_sprite(sprPcHudStammoGauge, 0, chargeMeterx, 43 + meterJiggle);
    whitebardrawy = chargeMetery + 5;
    
    if (whitebardrawy > 232)
        whitebardrawy = 232;
    
    if (global.stammo > 0)
        draw_sprite_ext(sprDot, 0, chargeMeterx + 5, whitebardrawy, 10, -stammoMeter + 5, 0, c_white, 1);
    
    for (i = 0; i < meterLength; i += 1)
    {
        chargeSprite = 419;
        
        if (i < stammoMeter)
        {
            chargeSprite = 419;
            
            if (chargeFrame[i] <= 3)
                chargeFrame[i] += 0.8;
            
            if (i == 0)
            {
                chargeSprite = 421;
                
                if (chargeFrame[i] == 0)
                    chargeFrame[i] = 1;
            }
        }
        else
        {
            chargeSprite = 418;
            
            if (chargeFrame[i] >= 1)
                chargeFrame[i] -= 0.8;
        }
        
        if (i >= (stammoMeter - stammoAmmoCon))
            consIndic = 1;
        else
            consIndic = 0;
        
        if (i < stammoHighlight)
            consIndic = hla;
        
        bardrawy = floor(chargeMetery - (i * cbl));
        
        if (bardrawy < 232)
            draw_sprite(chargeSprite, chargeFrame[i], chargeMeterx + 4, bardrawy);
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
                draw_sprite(sprPcHudStammoDivide, 1, chargeMeterx + 4, floor(chargeMetery - (i * cbl)));
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
            draw_sprite(sprPcHudStammoDivide, 0, chargeMeterx + 4, floor(chargeMetery - (i * cbl)));
            draw_sprite(sprPcHudStammoDivide, 1, chargeMeterx + 4, floor((chargeMetery - (i * cbl)) + 1));
            draw_sprite(sprPcHudStammoDivide, 1, chargeMeterx + 4, floor(chargeMetery - (i * cbl) - 1));
            
            if (i == (stammoMeter - stammoAmmoCon))
            {
                if (consIndic == 1)
                    consIndic = 0;
            }
            
            if (i == stammoHighlight)
                consIndic = hla;
        }
        else if (i == stammoMeter || i == 1)
        {
            draw_sprite(sprPcHudStammoDivide, 1, chargeMeterx + 4, floor((chargeMetery - (i * cbl)) + 1));
        }
    }
    
    draw_sprite(sprPcHudStammoGauge, 1, chargeMeterx, 43 + meterJiggle);
    
    if (hudAmmoJiggle > 0)
        hudAmmoJiggle -= 1;
    
    if (hudAmmoJiggle < 0)
        hudAmmoJiggle = 0;
    
    if (global.pFired)
        hudAmmoJiggle = 2;
    
    draw_set_halign(fa_center);
    chargeText = string(global.stammo);
    chargeTextx = viewx + 16 + hudAmmoJiggle + 160;
    chargeTexty = metery + 3 + hudAmmoJiggle;
    drawSpriteAmmoNumber(chargeTextx + 4, 239 + hudAmmoJiggle, chargeText);
    draw_sprite(gaugeSprite, 1, viewx, metery);
    
    if (global.showTimer)
        timerNumber(viewx - 54, viewy + 30 + 2);
    
    ugShowy = global.g_cameraHeight - 8 - 4;
    
    if (global.ugHave > 0)
    {
        for (i = 1; i <= global.ugHave; i += 1)
        {
            ugShowx = -98 + (16 * (i - 1));
            
            if (i > 6)
                ugShowx += 178;
            
            draw_sprite(global.ug[global.ugOrder[i]][2], 1, ugShowx, ugShowy);
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
}
