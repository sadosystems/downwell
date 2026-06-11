draw_self();

if (image_index == 15)
{
    if (lightUpLeft)
        draw_sprite(sprite_index, 25, x, y);
    
    if (lightUpRight)
        draw_sprite(sprite_index, 24, x, y);
    
    if (lightDownLeft)
        draw_sprite(sprite_index, 21, x, y);
    
    if (lightDownRight)
        draw_sprite(sprite_index, 20, x, y);
}
