textboxx = __view_get(e__VW.XView, 0);
textboxy = __view_get(e__VW.YView, 0) + 58;
draw_sprite(sprTextBox, 0, textboxx, textboxy);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(textboxx + 6, textboxy + 6, string_hash_to_newline(drawText));

if (showChoice)
{
    draw_text(textboxx + 8 + 8, textboxy + 32, string_hash_to_newline(choiceOption[0]));
    draw_text(textboxx + 88 + 8, textboxy + 32, string_hash_to_newline(choiceOption[1]));
    
    switch (cursorAt)
    {
        case 0:
            draw_text(textboxx + 8, textboxy + 32, string_hash_to_newline(">"));
            break;
        
        case 1:
            draw_text(textboxx + 88, textboxy + 32, string_hash_to_newline(">"));
            break;
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
