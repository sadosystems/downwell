function drawTouchButtons()
{
    if (global.touchButtonShow)
    {
        surfaceSet(global.surfaceButton);
        buttonsy = __view_get(e__VW.HView, 0) - 24;
        buttonsy += global.g_buttonYAdjustment;
        draw_set_valign(fa_bottom);
        
        if (global.dLeft)
            draw_sprite(spriteLeft, 1, 0, buttonsy);
        else
            draw_sprite(spriteLeft, 0, 0, buttonsy);
        
        if (global.dRight)
            draw_sprite(spriteRight, 1, leftEnd, buttonsy);
        else
            draw_sprite(spriteRight, 0, leftEnd, buttonsy);
        
        if (global.dUpHeld)
            draw_sprite(spriteJump, 1, 114, buttonsy);
        else
            draw_sprite(spriteJump, 0, 114, buttonsy);
        
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        surfaceReset();
    }
}

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
