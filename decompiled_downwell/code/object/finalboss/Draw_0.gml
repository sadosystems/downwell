drawShade();
draw_sprite(backSprite, image_index, x, y);
eyeKambotsu = 22 * (accumDamage / ouchAmt);
starex = (room_width / 2) + ((global.plx - (room_width / 2)) / 10);
eyex += ((starex - eyex) / 15);

if (state != 2 && !global.bossDead)
    draw_sprite(sprBossEye, 0, eyex, y + powan);

if (powan != 0)
{
    powan -= (powan / 30);
    
    if (abs(powan) < 0.2)
        powan = 0;
}

draw_sprite(frontSprite, image_index, x, y);
i = 0;

repeat (16)
{
    draw_sprite(sprBossBody, hitStun, x, y + 96 + (48 * i));
    i += 1;
}
