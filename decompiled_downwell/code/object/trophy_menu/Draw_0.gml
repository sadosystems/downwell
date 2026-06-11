var vx = __view_get(e__VW.XView, 0);
var vy = __view_get(e__VW.YView, 0);
var ditheryTop = vy + 90;
var ditheryBottom = ditheryTop + 80;

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
scrDrawBorderTextBlack(vx + 80, vy + 48 + wholePowan, menuTitleText);
scrDrawBorderTextBlack(vx + 80, vy + 60 + wholePowan, trophyCountString);
var spriteX = vx + 80;
var spriteY = vy + 144;
draw_sprite_ext(sprSelectArrow, 0, spriteX - 28, spriteY + wholePowan, 1, 1, 180, c_white, 1);
draw_sprite_ext(sprSelectArrow, 0, spriteX + 28, spriteY + wholePowan, 1, 1, 0, c_white, 1);
draw_sprite(sprTrophiesBorder, 0, spriteX, spriteY + wholePowan);
var yOffsetForText = 24;

if (trophyUnlocked[displayedTrophy])
{
    draw_set_color(c_red);
    draw_set_valign(fa_bottom);
    draw_text(spriteX - 1, (spriteY - yOffsetForText) + wholePowan + 1, string_hash_to_newline(trophyNameText[displayedTrophy]));
    draw_set_valign(fa_top);
    draw_text(spriteX - 1, spriteY + yOffsetForText + wholePowan + 1 + 2, string_hash_to_newline(trophyDescText[displayedTrophy]));
    draw_set_color(c_white);
    draw_set_valign(fa_bottom);
    draw_text(spriteX, (spriteY - yOffsetForText) + wholePowan, string_hash_to_newline(trophyNameText[displayedTrophy]));
    draw_set_valign(fa_top);
    draw_text(spriteX, spriteY + yOffsetForText + wholePowan + 2, string_hash_to_newline(trophyDescText[displayedTrophy]));
    draw_sprite(sprTrophies, displayedTrophy, spriteX, spriteY + wholePowan);
}
else
{
    draw_set_color(c_red);
    draw_set_valign(fa_bottom);
    draw_text(spriteX, (spriteY - yOffsetForText) + wholePowan, string_hash_to_newline(trophyNameText[displayedTrophy]));
    draw_set_valign(fa_top);
    draw_text(spriteX, spriteY + yOffsetForText + wholePowan + 2, string_hash_to_newline(trophyDescText[displayedTrophy]));
    draw_set_color(c_white);
    draw_sprite(sprLocked, 0, spriteX, (spriteY - 2) + wholePowan);
}

var powany = -2;
var menuTexty = ditheryTop + 20 + 96 + powany + wholePowan + 16;
var menuTextx = vx + 80;
draw_set_color(c_red);
draw_text((menuTextx + powan) - 1, menuTexty + 1, string_hash_to_newline(backText));
draw_set_color(c_white);
draw_text(menuTextx + powan, (menuTexty + 1) - floor(powan), string_hash_to_newline(backText));
draw_set_valign(fa_top);

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
