function scrGemmyText(arg0, arg1, arg2)
{
    gemmyx = arg0;
    gemmyy = arg1;
    gemmyText = arg2;
    draw_set_colour(c_red);
    draw_text(gemmyx - 1, gemmyy, string_hash_to_newline(gemmyText));
    draw_text(gemmyx, gemmyy - 1, string_hash_to_newline(gemmyText));
    draw_set_colour(c_black);
    draw_text(gemmyx + 1, gemmyy, string_hash_to_newline(gemmyText));
    draw_text(gemmyx, gemmyy + 1, string_hash_to_newline(gemmyText));
    draw_set_colour(c_white);
    draw_text(gemmyx, gemmyy, string_hash_to_newline(gemmyText));
}
