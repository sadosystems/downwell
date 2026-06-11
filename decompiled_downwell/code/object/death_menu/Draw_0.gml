vx = __view_get(e__VW.XView, 0);
vy = __view_get(e__VW.YView, 0);
draw_sprite_tiled(sprDitherFade, 5, 0, 0);
ditheryTop = vy + 90 + 6;
ditheryBottom = ditheryTop + 112;

for (i = 0; i <= 7; i += 1)
{
    for (t = 0; t <= 160; t += 8)
    {
        draw_sprite(sprDitherFade, i, vx + t, (ditheryTop + 0) - (i * 8));
        draw_sprite(sprDitherFade, i, vx + t, ditheryBottom + (i * 8));
    }
}

draw_set_color(c_black);
draw_rectangle(vx, ditheryTop - 16, vx + 160, ditheryBottom, 0);
draw_set_halign(fa_center);
scrDrawBorderTextBlack(vx + 80, vy + 64 + wholePowan, pauseText);
resultStuffx = vx + 42;
resultColon = resultStuffx + 20;
resultStuffy = (ditheryTop + 6 + wholePowan) - 8 - 6;

if (rs[0][0])
{
    draw_sprite(sprResultStuff, 3, resultStuffx, resultStuffy);
    draw_sprite(sprResultStuff, 0, resultColon, resultStuffy);
    smallNumberArea(vx + 72, resultStuffy + rs[0][1]);
}

resultStuffy += 10;

if (rs[1][0])
{
    draw_sprite(sprResultStuff, 1, resultStuffx, resultStuffy);
    draw_sprite(sprResultStuff, 0, resultColon, resultStuffy);
    smallNumber(vx + 72, resultStuffy + rs[1][1], global.gameGem);
}

resultStuffy += 10;

if (rs[2][0])
{
    draw_sprite(sprResultStuff, 4, resultStuffx, resultStuffy);
    draw_sprite(sprResultStuff, 0, resultColon, resultStuffy);
    smallNumber(vx + 72, resultStuffy + rs[2][1], global.killCount);
}

resultStuffy += 14;

if (rs[3][0])
{
    draw_sprite(sprResultStuff, 5, resultStuffx, resultStuffy);
    draw_sprite(sprResultStuff, 0, resultColon, resultStuffy);
    smallNumber(vx + 72, resultStuffy + rs[3][1], global.highCombo);
}

resultStuffy += 14;

if (rs[4][0])
{
    draw_sprite(sprResultStuff, 6, resultStuffx, resultStuffy);
    draw_sprite(sprResultStuff, 0, resultColon, resultStuffy);
    timerNumber(vx + 72 + 42, resultStuffy + rs[4][1]);
}

if (tng[gr] <= fakeTotalGems && !goalPassed)
{
    fakeTotalGems = tng[gr];
    goalNotif = 1;
    alarm[1] = 45;
    powanDesc = 4;
    powanText = 4;
    popFrame = 0;
    goalPassed = 1;
    unlockNotice(gr);
}

nextGoal = tng[gr];
gemProgy = (ditheryTop + 72 + wholePowan2 + rs[5][1]) - 8;

if (rs[5][0])
{
    draw_set_valign(fa_top);
    draw_sprite(sprProgress, 0, __view_get(e__VW.XView, 0) + 80, gemProgy - 8);
    draw_set_halign(fa_right);
    scrDrawBorderTextBlack((__view_get(e__VW.XView, 0) + 80) - 8, gemProgy, string(fakeTotalGems));
    draw_set_halign(fa_center);
    scrDrawBorderTextBlack(__view_get(e__VW.XView, 0) + 80, gemProgy, "/");
    draw_set_halign(fa_left);
    
    if (!global.unlockMax)
    {
        scrDrawBorderTextBlack(__view_get(e__VW.XView, 0) + 80 + 8, gemProgy, nextGoal);
    }
    else
    {
        draw_set_color(c_red);
        draw_text(__view_get(e__VW.XView, 0) + 80 + 8, gemProgy + 1, string_hash_to_newline(maxedText));
        draw_set_color(c_white);
        draw_text(__view_get(e__VW.XView, 0) + 80 + 8, gemProgy, string_hash_to_newline(maxedText));
    }
    
    progBary = round(gemProgy + 14 + 3);
    progBarMaxLength = 96;
    progBarx = (vx + 80) - (progBarMaxLength / 2);
    
    if (!global.unlockMax)
    {
        draw_set_color(c_red);
        draw_sprite_stretched(sprPixel, 1, progBarx, progBary, progBarMaxLength, 1);
        draw_sprite_stretched(sprPixel, 1, progBarx + 1, progBary + 1, progBarMaxLength - 2, 1);
        draw_sprite_stretched(sprPixel, 1, progBarx + 1, progBary - 1, progBarMaxLength - 2, 1);
    }
    
    if (gr > 0)
        progBarLength = 96 * ((fakeTotalGems - tng[gr - 1]) / (nextGoal - tng[gr - 1]));
    else
        progBarLength = 96 * (fakeTotalGems / nextGoal);
    
    if (rs[6][0] && !goalPassed)
    {
        if (fakeTotalGems < global.totalGems)
        {
            if (gr > 0)
            {
                if (ceil((global.totalGems - fakeTotalGems) / 15) < ceil((nextGoal - tng[gr - 1]) / 30))
                    fakeTotalGems += ceil((global.totalGems - fakeTotalGems) / 15);
                else
                    fakeTotalGems += ceil((nextGoal - tng[gr - 1]) / 30);
            }
            else if (ceil((global.totalGems - fakeTotalGems) / 15) < ceil(nextGoal / 30))
            {
                fakeTotalGems += ceil((global.totalGems - fakeTotalGems) / 15);
            }
            else
            {
                fakeTotalGems += ceil(nextGoal / 30);
            }
            
            filling += 1;
            
            if ((filling % 3) == 0)
            {
                fillsnd = soundPlayOL(328, 90, 0, 1, "UI");
                fillpitch = 1 + ((progBarLength / 96) * 1.2);
                audio_sound_pitch(fillsnd, fillpitch);
            }
        }
        else
        {
            fakeTotalGems = global.totalGems;
            
            if (!sequenceOver)
            {
                soundPlayOL(330, 80, 0, 1, "UI");
                sequenceOver = 1;
            }
        }
    }
    
    progBarShow = progBarLength;
    draw_set_color(c_white);
    
    if (!global.unlockMax)
    {
        draw_sprite_stretched(sprPixel, 0, progBarx, progBary, progBarShow, 1);
        
        if (progBarShow > 1)
        {
            draw_sprite_stretched(sprPixel, 0, progBarx + 1, progBary + 1, progBarShow - 2, 1);
            draw_sprite_stretched(sprPixel, 0, progBarx + 1, progBary - 1, progBarShow - 2, 1);
        }
    }
    
    if (gr > 0)
        sep = 96 * ((fakeTotalSep - tng[gr - 1]) / (nextGoal - tng[gr - 1]));
    else
        sep = 96 * (fakeTotalSep / nextGoal);
    
    if (sep <= 3)
        sep = -1000;
    
    draw_set_color(c_red);
    draw_sprite(sprPixel, 1, progBarx + sep, progBary);
    draw_sprite(sprPixel, 1, (progBarx + sep) - 1, progBary + 1);
    draw_sprite(sprPixel, 1, (progBarx + sep) - 1, progBary - 1);
    draw_sprite(sprPixel, 1, progBarx + sep + 1, progBary);
    draw_sprite(sprPixel, 1, ((progBarx + sep) - 1) + 1, progBary + 1);
    draw_sprite(sprPixel, 1, ((progBarx + sep) - 1) + 1, progBary - 1);
    
    if (goalPassed)
    {
        if (!popped)
        {
            soundPlayOL(329, 90, 0, 1, "UI");
            popped = 1;
        }
        
        draw_sprite(sprProgPop, popFrame, progBarx + 95, progBary);
        
        if (popFrame < 4)
            popFrame += 0.5;
        
        uny = __view_get(e__VW.YView, 0) + 64 + 16;
        
        if (goalNotif >= 2)
        {
            draw_sprite(sprShopDesc, 0, __view_get(e__VW.XView, 0), uny + powanDesc);
            
            if (powanDesc > 0)
                powanDesc -= 1;
        }
        
        if (goalNotif >= 3)
        {
            draw_set_halign(fa_center);
            
            if (unlockType == 0)
            {
                styleUnlockSpriteFrame += 0.3;
                topTxt = (uny + 20 + powanText) - 4;
                scrGemmyText(__view_get(e__VW.XView, 0) + 80, topTxt, styleUnlockText);
                draw_sprite(unlockSprite, styleUnlockSpriteFrame, __view_get(e__VW.XView, 0) + 80, topTxt + 32);
                scrDrawBorderTextBlack(__view_get(e__VW.XView, 0) + 80, topTxt + 32 + 16, unlockName);
            }
            else if (unlockType == 1)
            {
                topTxt = (uny + 16 + powanText) - 4;
                scrGemmyText(__view_get(e__VW.XView, 0) + 80, topTxt, paletteUnlockText);
                scrDrawBorderTextBlack(__view_get(e__VW.XView, 0) + 80, topTxt + 34, global.shaderAr[global.shaderArUnlocked][1]);
            }
            
            if (powanText > 0)
                powanText -= 1;
        }
    }
    else
    {
        popped = 0;
    }
}

if (!goalPassed && sequenceOver)
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_red);
    
    for (i = 0; i <= maxMenu; i += 1)
    {
        if (cursorAt == i)
            selected = 1;
        else
            selected = 0;
        
        powany = 0;
        
        if (cursorAt >= i)
            powany = -2;
        
        apartByx = 8;
        apartByy = 10;
        menuTexty = ditheryTop + 80 + (i * apartByy) + powany + wholePowan2 + 12;
        menuTextx = vx + 8 + 8 + (i * apartByx);
        
        if (selected)
        {
            draw_set_color(c_red);
            draw_text((menuTextx + powan) - 1, menuTexty + 1, string_hash_to_newline(pauseMenu[i]));
            draw_set_color(c_white);
            draw_text(menuTextx + powan, (menuTexty + 1) - floor(powan), string_hash_to_newline(pauseMenu[i]));
        }
        else
        {
            draw_set_color(c_red);
            draw_text(menuTextx, menuTexty, string_hash_to_newline(pauseMenu[i]));
        }
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
