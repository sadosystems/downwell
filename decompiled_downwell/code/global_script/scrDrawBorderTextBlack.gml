function scrDrawBorderTextBlack(arg0, arg1, arg2)
{
    sx = arg0;
    sy = arg1;
    txt = string(arg2);
    draw_set_color(c_black);
    draw_text(sx + 1, sy, string_hash_to_newline(txt));
    draw_text(sx - 1, sy, string_hash_to_newline(txt));
    draw_text(sx, sy + 1, string_hash_to_newline(txt));
    draw_text(sx, sy - 1, string_hash_to_newline(txt));
    draw_set_color(c_white);
    draw_text(sx, sy, string_hash_to_newline(txt));
}
