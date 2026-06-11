vx = __view_get(e__VW.XView, 0);
vy = __view_get(e__VW.YView, 0) + yall;
screenCenter_y = vy + (global.g_cameraHeight / 2);

if (yall != 0)
{
    yall -= (yall / 15);
    
    if (abs(yall) < 1)
        yall = 0;
}

runFrame += runSpeed;
titley = vy + 64 + 8;
titley = screenCenter_y - 70;

if (!selected)
{
    draw_set_halign(fa_center);
    
    if (global.hardMode)
        drawWhompText(vx + 80, (titley + 1) - 14, hardModeText, 4, 0.06);
    
    draw_set_color(c_red);
    draw_text(vx + 80, titley + 1, string_hash_to_newline(styleSelectText));
    draw_set_color(c_white);
    draw_text(vx + 80, titley, string_hash_to_newline(styleSelectText));
    xapart = 48;
    cursorx = cursorAt * xapart;
    
    if (smoothx != cursorx)
    {
        smoothx += ((cursorx - smoothx) / 5);
        
        if (abs(cursorx - smoothx) < 1)
            smoothx = cursorx;
    }
    
    for (i = 0; i <= styleMax; i += 1)
    {
        drawx = (vx + 80 + (i * xapart)) - smoothx;
        drawy = (vy + 128) - (power(drawx - (vx + 80), 2) / 200);
        drawy = screenCenter_y - (142 - (128 - (power(drawx - (vx + 80), 2) / 200)));
        
        if (global.styleUnlock >= i)
            prevSprite = styleRun[i];
        else
            prevSprite = 43;
        
        if (cursorAt == i)
            draw_sprite(prevSprite, runFrame, drawx, drawy);
        else
            draw_sprite(prevSprite, 0, drawx, drawy);
    }
    
    for (i = 0; i <= bordery; i += 1)
    {
        draw_sprite(global.levelTile[1], 13, 0, tiley + (i * 16));
        draw_sprite(global.levelTile[1], 7, 160, tiley + (i * 16));
    }
    
    for (i = bordery; i <= tileMaxy; i += 1)
    {
        draw_sprite(global.levelTile[1], 13, 16, tiley + (i * 16));
        draw_sprite(global.levelTile[1], 7, 144, tiley + (i * 16));
    }
    
    tiley -= 6;
    
    if (tiley <= -16)
        tiley += 16;
    
    if (global.hardUnlocked)
    {
        drawx = (vx + 80 + (-1 * hardApart)) - smoothx;
        drawy = vy + 128;
        drawy = screenCenter_y - 14;
        
        if (global.hardMode)
            imgindex = 1;
        else
            imgindex = 0;
        
        draw_sprite(sprHardSkull, imgindex, drawx, drawy);
    }
    
    if (cursorAt < styleMax)
        draw_sprite_ext(sprSelectArrow, 0, vx + 80 + 16, (screenCenter_y - 14) + 4, 1, 1, 0, c_white, 1);
    
    if (cursorAt > 0)
        draw_sprite_ext(sprSelectArrow, 0, (vx + 80) - 16, (screenCenter_y - 14) + 4, -1, 1, 0, c_white, 1);
    
    texty = vy + 64 + 80 + 8;
    texty = screenCenter_y - -10;
    
    if (global.styleUnlock >= cursorAt)
    {
        draw_set_color(c_red);
        draw_text(vx + 80, texty + 1, string_hash_to_newline(styleName[cursorAt]));
        draw_set_color(c_white);
        draw_text(vx + 80, texty, string_hash_to_newline(styleName[cursorAt]));
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        scrDrawBorderTextBlack(vx + 80, texty + 16 + 6, styleDesc[cursorAt]);
    }
    else
    {
        draw_set_color(c_red);
        draw_text(vx + 80, texty + 1, string_hash_to_newline(lockedText));
        draw_set_color(c_white);
        draw_text(vx + 80, texty, string_hash_to_newline(lockedText));
    }
}
else
{
    drawy = screenCenter_y - 14;
    draw_sprite(styleRun[cursorAt], runFrame, vx + 80, drawy + plSpDescend);
    ysp += 0.05;
    plSpDescend += ysp;
}

dithy += 16;
draw_sprite(sprEnterDither, 0, vx + 80, dithy);

if (selected)
{
    if (vdithy < 320)
        vdithy += 10;
    else
        scrNextLevel(1);
    
    draw_sprite(sprVertDither, 0, vx + 80, vdithy);
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
