draw_set_color(c_white);

if (held)
    draw_line(x, y, global.plx, global.ply);
else
    draw_line(x, y, x, y + stringLength + 4);

draw_self();
