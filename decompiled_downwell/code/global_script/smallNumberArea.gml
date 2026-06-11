function smallNumberArea(arg0, arg1)
{
    smalx = arg0;
    smaly = arg1;
    draw_sprite(sprNumbers, global.area, smalx + 0, smaly);
    draw_sprite(sprNumbers, 10, smalx + 6 + 1, smaly);
    draw_sprite(sprNumbers, global.level, smalx + 12, smaly);
}
