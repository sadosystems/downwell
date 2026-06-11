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
draw_set_valign(fa_top);
scrDrawBorderTextBlack(vx + 80, vy + 72 + wholePowan, pauseText);
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
    menuTexty = ditheryTop + 20 + (i * apartByy) + powany + wholePowan2;
    menuTextx = (vx + 32 + (i * apartByx)) - 24;
    
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
