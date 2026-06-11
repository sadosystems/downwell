function drawTouchButtonsTabletFront()
{
    if (global.touchButtonShow)
    {
        surfaceSet(global.surfaceButton);
        draw_set_valign(fa_bottom);
        draw_sprite(spriteLeft, global.dLeft, leftButtonx, buttonsy);
        draw_sprite(spriteRight, global.dRight, rightButtonx, buttonsy);
        draw_sprite(spriteJump, global.dUpHeld, upButtonx, buttonsy);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        surfaceReset();
    }
}
