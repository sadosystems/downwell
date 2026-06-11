draw_self();

for (i = 16; i < chainLength; i += 16)
    draw_sprite(sprite_index, 0, x, y - i);
