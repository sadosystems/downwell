drawShade();

if (direction >= 0 && direction < (ang16 * 1))
{
    eye = 357;
    eyex = 1;
}
else if (direction >= (ang16 * 1) && direction < (ang16 * 3))
{
    eye = 360;
    eyex = 1;
}
else if (direction >= (ang16 * 3) && direction < (ang16 * 5))
{
    eye = 361;
    eyex = 1;
}
else if (direction >= (ang16 * 5) && direction < (ang16 * 7))
{
    eye = 360;
    eyex = -1;
}
else if (direction >= (ang16 * 7) && direction < (ang16 * 9))
{
    eye = 357;
    eyex = -1;
}
else if (direction >= (ang16 * 9) && direction < (ang16 * 11))
{
    eye = 358;
    eyex = -1;
}
else if (direction >= (ang16 * 11) && direction < (ang16 * 13))
{
    eye = 359;
    eyex = -1;
}
else if (direction >= (ang16 * 13) && direction < (ang16 * 15))
{
    eye = 358;
    eyex = 1;
}
else if (direction >= (ang16 * 15) && direction < ((ang16 * 16) - 1))
{
    eye = 357;
    eyex = 1;
}

sprite_index = eye;
image_xscale = eyex;

if (hitStun)
{
    shader_set(shaderHit);
    draw_self();
    shader_reset();
}
else
{
    draw_self();
}
