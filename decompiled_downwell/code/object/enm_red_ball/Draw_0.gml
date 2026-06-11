drawShade();
draw_self();

if (playerDir >= 0 && playerDir < (ang16 * 1))
{
    eye = 182;
    eyex = 1;
    shotDir = 0;
}
else if (playerDir >= (ang16 * 1) && playerDir < (ang16 * 3))
{
    eye = 184;
    eyex = 1;
    shotDir = 45;
}
else if (playerDir >= (ang16 * 3) && playerDir < (ang16 * 5))
{
    eye = 185;
    eyex = 1;
    shotDir = 90;
}
else if (playerDir >= (ang16 * 5) && playerDir < (ang16 * 7))
{
    eye = 184;
    eyex = -1;
    shotDir = 135;
}
else if (playerDir >= (ang16 * 7) && playerDir < (ang16 * 9))
{
    eye = 182;
    eyex = -1;
    shotDir = 180;
}
else if (playerDir >= (ang16 * 9) && playerDir < (ang16 * 11))
{
    eye = 183;
    eyex = -1;
    shotDir = 225;
}
else if (playerDir >= (ang16 * 11) && playerDir < (ang16 * 13))
{
    eye = 181;
    eyex = -1;
    shotDir = 270;
}
else if (playerDir >= (ang16 * 13) && playerDir < (ang16 * 15))
{
    eye = 183;
    eyex = 1;
    shotDir = 315;
}
else if (playerDir >= (ang16 * 15) && playerDir < ((ang16 * 16) - 1))
{
    eye = 182;
    eyex = 1;
    shotDir = 0;
}

draw_sprite_ext(eye, image_index, x, y - 5, eyex, 1, 0, c_white, 1);
