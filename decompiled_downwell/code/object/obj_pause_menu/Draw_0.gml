if (global.isPaused)
{
    vx = __view_get(e__VW.XView, 0);
    vy = __view_get(e__VW.YView, 0);
    ditheryTop = (vy + 90) - 8;
    ditheryBottom = ditheryTop + 80;
    
    for (i = 0; i <= 7; i += 1)
    {
        for (t = 0; t <= 160; t += 8)
        {
            draw_sprite(sprDitherFade, i, vx + t, ditheryTop - (i * 8));
            draw_sprite(sprDitherFade, i, vx + t, ditheryBottom + (i * 8));
        }
    }
    
    draw_set_color(c_black);
    draw_rectangle(vx, ditheryTop, vx + 160, ditheryBottom, 0);
    draw_set_halign(fa_center);
    
    if (global.area > 0)
    {
        if (!global.hardMode)
            areaText = localAreaText + "-" + string(global.level);
        else
            areaText = localAreaText + "-H" + string(global.level);
    }
    else
    {
        areaText = localAreaText;
    }
    
    scrDrawBorderTextBlack(vx + 80, (ditheryTop - 16) + wholePowan, pauseText);
    scrDrawBorderTextBlack(vx + 80, (ditheryTop - 16) + 14 + wholePowan, areaText);
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
        menuTexty = ditheryTop + 28 + (i * apartByy) + powany + wholePowan2;
        menuTextx = (vx + 32 + (i * apartByx)) - 16;
        
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
    
    nextGoal = tng[gr];
    gemProgy = ((ditheryTop + 72 + wholePowan2) - 8) + 42;
    
    if (global.isPC)
        gemProgy += 16;
    
    draw_sprite(sprProgress, 0, __view_get(e__VW.XView, 0) + 80, gemProgy - 8);
    draw_set_halign(fa_right);
    scrDrawBorderTextBlack((__view_get(e__VW.XView, 0) + 80) - 8, gemProgy, string(global.totalGems));
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
    
    progBary = gemProgy + 14 + 0;
    progBarMaxLength = 96;
    progBarx = (vx + 80) - (progBarMaxLength / 2);
    
    if (!global.unlockMax)
    {
        draw_set_color(c_red);
        draw_line(progBarx, progBary, progBarx + progBarMaxLength, progBary);
        draw_line(progBarx + 1, progBary + 1, (progBarx + progBarMaxLength) - 1, progBary + 1);
        draw_line(progBarx + 1, progBary - 1, (progBarx + progBarMaxLength) - 1, progBary - 1);
        
        if (gr > 0)
            progBarLength = progBarMaxLength * ((global.totalGems - tng[gr - 1]) / (nextGoal - tng[gr - 1]));
        else
            progBarLength = progBarMaxLength * (global.totalGems / nextGoal);
        
        progBarShow = progBarLength;
        draw_set_color(c_white);
        draw_line(progBarx, progBary, progBarx + progBarShow, progBary);
        
        if (progBarShow > 1)
        {
            draw_line(progBarx + 1, progBary + 1, (progBarx + progBarShow) - 1, progBary + 1);
            draw_line(progBarx + 1, progBary - 1, (progBarx + progBarShow) - 1, progBary - 1);
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
