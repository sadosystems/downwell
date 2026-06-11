i = 0;

for (i = 0; i <= bordery; i += 1)
{
    draw_sprite(global.levelTile[global.area], 13, 0, tiley + (i * 16));
    draw_sprite(global.levelTile[global.area], 7, 160, tiley + (i * 16));
}

for (i = bordery; i <= tileMaxy; i += 1)
{
    draw_sprite(global.levelTile[global.area + 1], 13, 8, tiley + (i * 16));
    draw_sprite(global.levelTile[global.area + 1], 7, 152, tiley + (i * 16));
}

if (global.area != 3)
    tiley -= 6;
else
    tiley -= 3;

if (tiley <= -16)
{
    tiley += 16;
    
    if (next > 2 && global.level == 3)
    {
        if (bordery > 0)
            bordery -= 1;
    }
}

global.playerImageIndex += global.playerImageSpeed;
draw_sprite_ext(global.playerSprite, global.playerImageIndex, global.plx, global.ply, global.plxDir, 1, 0, c_white, 1);
bonusTxt = "COMBO#BONUS##" + string(gemGetMem);
circle += 3;
lenx = global.gemGet / 50;

if (lenx > 32)
    lenx = 32;

cirx = lengthdir_x(1, circle);
ciry = lengthdir_y(1, circle);
draw_set_halign(fa_center);
draw_set_color(c_red);
i = 0;

repeat (6)
{
    draw_text(bonusx - abs(cirx * i), bonusy - abs(cirx * i), string_hash_to_newline(string(global.area) + "-" + string(global.level) + "#" + cleartext));
    i += 1;
}

draw_set_color(c_white);
draw_text(bonusx - abs(cirx * i), bonusy - abs(cirx * i), string_hash_to_newline(string(global.area) + "-" + string(global.level) + "#" + cleartext));

if (showBonus)
{
    draw_set_color(c_red);
    i = 0;
    
    while (true)
    {
        draw_text(bonusx - i, bonusy - i, string_hash_to_newline(bonusTxt));
        i += 1;
        
        if (i >= abs(lenx))
            break;
    }
    
    draw_set_color(c_white);
    draw_text(bonusx - abs(lenx), bonusy - abs(lenx), string_hash_to_newline(bonusTxt));
}

if (showHeart)
{
    draw_set_color(c_red);
    i = 0;
    
    repeat (6)
    {
        draw_text(heartx - abs(cirx * i), hearty - abs(cirx * i), string_hash_to_newline("LIFE UP!"));
        i += 1;
    }
    
    draw_set_color(c_white);
    draw_text(heartx - abs(cirx * i), hearty - abs(cirx * i), string_hash_to_newline("LIFE UP!"));
}

if (showLevelUp)
{
    draw_set_color(c_red);
    i = 0;
    levelTxt = chooseText;
    
    repeat (6)
    {
        draw_text(levelx - abs(cirx * i), (levely - abs(cirx * i)) + 8, string_hash_to_newline(levelTxt));
        i += 1;
    }
    
    draw_set_color(c_white);
    draw_text(levelx - abs(cirx * i), (levely - abs(cirx * i)) + 8, string_hash_to_newline(levelTxt));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    time += 1;
    
    for (i = 0; i <= levelUgMax; i += 1)
    {
        ugSprX = levelUgSmooth + (ugSprSpace * i);
        ugSprY = ((ugdescy + 36 + (abs(ugSprX - 80) / 2)) - (6 * abs(sin(time / 20)))) + 8;
        
        if (ugSprY > (ugdescy + 36 + 8))
            ugSprY = ugdescy + 36 + 8;
        
        draw_sprite(global.ug[levelUg[i]][2], 0, ugSprX, ugSprY);
    }
    
    draw_set_valign(fa_top);
    textUgName = ugNameText[cursorAt];
    textUgDesc = ugDescText[cursorAt];
    
    if (global.ug[levelUg[cursorAt]][1] > 0)
        textUgName += (" " + string(global.ug[levelUg[cursorAt]][1] + 1));
    
    draw_set_halign(fa_center);
    scrDrawBorderTextJp(80, ugdescy + 10, string(textUgName));
    draw_set_halign(fa_center);
    scrDrawBorderTextJp(80, ugdescy + 72, textUgDesc);
    draw_set_valign(fa_middle);
}
