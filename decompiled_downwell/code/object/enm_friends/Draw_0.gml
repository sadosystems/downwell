if (allSet)
{
    for (i = 0; i <= 1; i += 1)
    {
        if (elderBro[i] && broAlive[i])
        {
            draw_sprite_ext(sprBond, 0, x, y, broDistance[i], 1, point_direction(x, y, brother[i].x, brother[i].y), c_white, 1);
            draw_self();
            
            with (brother[i])
                draw_self();
            
            draw_sprite_ext(sprBond, 1, x, y, broDistance[i], 1, point_direction(x, y, brother[i].x, brother[i].y), c_white, 1);
        }
        else
        {
            draw_self();
        }
    }
}
