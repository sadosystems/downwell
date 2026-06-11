function surfaceClear(arg0)
{
    if (surface_exists(arg0))
    {
        surface_set_target(arg0);
        draw_clear_alpha(c_black, 0);
        surface_reset_target();
    }
}
