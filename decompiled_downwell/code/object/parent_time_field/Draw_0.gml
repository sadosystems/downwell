if (!global.pTimeStop)
    radius = random_range(radiusMin, radiusMax);

if (parentCamera.x > 160 && parentCamera.x < (room_width - 160))
{
    draw_set_colour(c_white);
    draw_circle(x, y, radius, 1);
    draw_circle(x, y, radius - 1, 1);
    draw_set_colour(c_red);
    draw_circle(x, y, radius + 1, 1);
}
