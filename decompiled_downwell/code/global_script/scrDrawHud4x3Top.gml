function scrDrawHud4x3Top()
{
    viewx = __view_get(e__VW.XView, 0);
    vieww = __view_get(e__VW.WView, 0);
    viewy = __view_get(e__VW.YView, 0);
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
    
    if (global.gemStreak > 0 && !global.death)
    {
        gemStreakAscend += ((16 - gemStreakAscend) / 8);
        gemStreakDrawy = round((viewy + 24 + 4) - gemStreakAscend);
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
                    scrGemmyText(gemStreakDrawx, gemStreakDrawy + 1 + 5, gemStreakText);
                    draw_sprite(sprGemS, 0, (gemStreakDrawx - round(string_width(string_hash_to_newline(string(gemStreakText))) / 2)) + 4, gemStreakDrawy + 4 + 1);
                }
            }
        }
    }
    
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
