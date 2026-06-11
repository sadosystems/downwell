function drawShadedText(arg0, arg1, arg2, arg3, arg4)
{
    drawx = arg0;
    drawy = arg1;
    drawText = arg2;
    mainColor = arg3;
    shadeColor = arg4;
    draw_set_color(shadeColor);
    draw_text(drawx + 1, drawy, string_hash_to_newline(drawText));
    draw_text(drawx + 1, drawy + 1, string_hash_to_newline(drawText));
    draw_text(drawx, drawy + 1, string_hash_to_newline(drawText));
    draw_set_color(mainColor);
    draw_text(drawx, drawy, string_hash_to_newline(drawText));
}
