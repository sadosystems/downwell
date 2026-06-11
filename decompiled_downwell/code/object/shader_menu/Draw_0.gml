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
draw_set_halign(fa_center);
scrDrawBorderTextBlack(vx + 80, vy + 72 + wholePowan, pauseText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
shaderTextx = (vx + 80 + powanx) - 40;
shaderTexty = vy + 72 + 48 + wholePowan + (powanx * 1.5) + 16;
draw_set_color(c_red);
draw_text(shaderTextx - 1, shaderTexty + 1, string_hash_to_newline(string(global.shaderType) + "." + global.shaderAr[global.shaderType][1]));
draw_set_color(c_white);
draw_text(shaderTextx, shaderTexty, string_hash_to_newline(string(global.shaderType) + "." + global.shaderAr[global.shaderType][1]));
nextShad = global.shaderType + 1;

if (nextShad > global.shaderArUnlocked)
    nextShad -= (global.shaderArUnlocked + 1);

scrDrawBorderTextRed(shaderTextx + 8 + 2, shaderTexty + 12, string(nextShad) + "." + global.shaderAr[nextShad][1]);

if (global.shaderArUnlocked > 2)
{
    nextShad = global.shaderType + 2;
    
    if (nextShad > global.shaderArUnlocked)
        nextShad -= (global.shaderArUnlocked + 1);
    
    scrDrawBorderTextRed(shaderTextx + 8 + 8 + 2, shaderTexty + 12 + 8, string(nextShad) + "." + global.shaderAr[nextShad][1]);
}

prevShad = global.shaderType - 1;

if (prevShad < 0)
    prevShad += (global.shaderArUnlocked + 1);

scrDrawBorderTextRed(shaderTextx - 8 - 2, shaderTexty - 12, string(prevShad) + "." + global.shaderAr[prevShad][1]);

if (global.shaderArUnlocked > 2)
{
    prevShad = global.shaderType - 2;
    
    if (prevShad < 0)
        prevShad += (global.shaderArUnlocked + 1);
    
    scrDrawBorderTextRed(shaderTextx - 8 - 8 - 2, shaderTexty - 12 - 8, string(prevShad) + "." + global.shaderAr[prevShad][1]);
}

for (i = 0; i <= 160; i += 8)
{
    flvl = 7;
    draw_sprite(sprDitherFade, flvl, vx + i, shaderTexty - 12 - 8);
    draw_sprite(sprDitherFade, flvl - 1, vx + i, shaderTexty - 12 - 8 - 2);
    draw_sprite(sprDitherFade, flvl - 2, vx + i, shaderTexty - 12 - 8 - 4);
    draw_sprite(sprDitherFade, flvl - 3, vx + i, shaderTexty - 12 - 8 - 6);
    draw_sprite(sprDitherFade, flvl, vx + i, shaderTexty + 12 + 8);
    draw_sprite(sprDitherFade, flvl - 1, vx + i, shaderTexty + 12 + 8 + 2);
    draw_sprite(sprDitherFade, flvl - 2, vx + i, shaderTexty + 12 + 8 + 4);
    draw_sprite(sprDitherFade, flvl - 3, vx + i, shaderTexty + 12 + 8 + 6);
}

runFrame += 0.25;
draw_sprite(sprPlayerRunExg, runFrame, (vx + 80) - 8, vy + 72 + 16 + wholePowan + 8);
draw_sprite(sprGemM, runFrame, vx + 80 + 8, vy + 72 + 16 + wholePowan + 8 + 2);
draw_set_color(c_red);
draw_set_halign(fa_center);

for (i = 0; i <= maxMenu; i += 1)
{
    if (cursorAt == i)
        selected = 1;
    else
        selected = 0;
    
    powany = 0;
    
    if (cursorAt >= i)
        powany = -2;
    
    apartByx = 12;
    apartByy = 10;
    menuTexty = ditheryTop + 20 + 64 + (i * apartByy) + powany + wholePowan2 + 16;
    menuTextx = vx + 80 + (i * apartByx);
    
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
