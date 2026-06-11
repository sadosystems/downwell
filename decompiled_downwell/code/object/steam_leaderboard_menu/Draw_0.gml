vx = __view_get(e__VW.XView, 0);
vy = __view_get(e__VW.YView, 0);
ditheryTop = vy + 90;
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
draw_set_valign(fa_top);
draw_set_halign(fa_center);

switch (showingBoard)
{
    case 0:
        boardTitle = txtGems;
        break;
    
    case 1:
        boardTitle = txtGems;
        boardTitle += ("#" + steamName);
        break;
    
    case 2:
        boardTitle = txtCombo;
        break;
    
    case 3:
        boardTitle = txtCombo;
        boardTitle += ("#" + steamName);
        break;
    
    case 4:
        boardTitle = txtTime;
        break;
    
    case 5:
        boardTitle = txtTime;
        boardTitle += ("#" + steamName);
        break;
    
    case 6:
        boardTitle = txtTime;
        break;
    
    case 7:
        boardTitle = txtTime;
        boardTitle += ("#" + steamName);
        break;
}

draw_sprite_ext(sprSelectArrow, 0, vx + 80 + 70, vy + 48 + 8, 1, 1, 0, c_white, 1);
draw_sprite_ext(sprSelectArrow, 0, (vx + 80) - 70, vy + 48 + 8, -1, 1, 0, c_white, 1);

if (showingBoard < 6)
    scrDrawBorderTextBlack(vx + 80, vy + 48, boardTitle);
else
    scrDrawBorderTextRed(vx + 80, vy + 48, boardTitle);

lbShowy = vy + 80 + 8;

if (string(steam_rank[0]) != "-")
{
    for (i = 0; i <= 7; i += 1)
    {
        draw_set_halign(fa_left);
        slRank = steam_rank[i];
        scrDrawBorderTextBlack(vx + 8, lbShowy + (18 * i), slRank);
        draw_set_halign(fa_right);
        slName = steam_name[i];
        
        if (slName == steamName)
            scrDrawBorderTextRed((vx + 160) - 8, lbShowy + (18 * i), slName);
        else
            scrDrawBorderTextBlack((vx + 160) - 8, lbShowy + (18 * i), slName);
        
        slScore = steam_score[i];
        
        if (showingBoard >= 4 && showingBoard <= 7)
            slScore = steamConvertDownloadedTime(slScore);
        
        scrDrawBorderTextBlack((vx + 160) - 8, lbShowy + 9 + (18 * i), slScore);
    }
}
else
{
    draw_set_halign(fa_center);
    scrDrawBorderTextBlack(vx + 80, lbShowy + 16, "...");
}

draw_set_halign(fa_left);
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
    menuTexty = vy + 192 + 48 + (i * apartByy) + powany + wholePowan2;
    menuTextx = vx + 32 + (i * apartByx);
    
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
