if (allSet)
{
    if (elderBro && broAlive)
    {
        draw_sprite_ext(sprBond, 0, x, y, broDistance, 1, point_direction(x, y, brother.x, brother.y), c_white, 1);
        draw_self();
        
        with (brother)
            draw_self();
        
        draw_sprite_ext(sprBond, 1, x, y, broDistance, 1, point_direction(x, y, brother.x, brother.y), c_white, 1);
    }
    else
    {
        draw_self();
    }
}
