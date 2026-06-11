draw_set_valign(fa_top);
draw_set_color(c_white);
xplacement = -80;
draw_text(xplacement, 0, string_hash_to_newline(device_mouse_check_button(0, mb_any)));
draw_text(xplacement, 8, string_hash_to_newline(device_mouse_x_to_gui(0)));
draw_text(xplacement, 16, string_hash_to_newline(device_mouse_y_to_gui(0)));
draw_text(xplacement, 32, string_hash_to_newline(device_mouse_check_button(1, mb_any)));
draw_text(xplacement, 40, string_hash_to_newline(device_mouse_x_to_gui(1)));
draw_text(xplacement, 48, string_hash_to_newline(device_mouse_y_to_gui(1)));
draw_text(xplacement, 64, string_hash_to_newline(device_mouse_check_button(2, mb_any)));
draw_text(xplacement, 72, string_hash_to_newline(device_mouse_x_to_gui(2)));
draw_text(xplacement, 80, string_hash_to_newline(device_mouse_y_to_gui(2)));
draw_text(xplacement, 96, string_hash_to_newline(mouse_check_button(mb_any)));
draw_text(xplacement, 104, string_hash_to_newline(mouse_x - __view_get(e__VW.XView, 0)));
draw_text(xplacement, 112, string_hash_to_newline(mouse_y - __view_get(e__VW.YView, 0)));

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
