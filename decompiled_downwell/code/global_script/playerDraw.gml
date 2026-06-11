function playerDraw()
{
    if (!goalStop && !noDraw)
    {
        draw_set_halign(fa_center);
        
        if (global.gemStreak >= global.gemStreakThreshold && !global.death)
        {
            afterImageAmount = afterImageNumber * (global.gemStreakTimer / global.gemStreakTimerStart);
            
            if (afterImageAmount > afterImageNumber)
                afterImageAmount = afterImageNumber;
            
            afterImageDrawAmount = round(afterImageAmount);
            
            for (i = afterImageDrawAmount; i >= 0; i -= 1)
            {
                aiba = irandom_range(-1, 1);
                aibay = irandom_range(-2, 1);
                aiShader = 3;
                vy4shader = shader_get_uniform(aiShader, "vy");
                shader_set(aiShader);
                shader_set_uniform_f(vy4shader, __view_get(e__VW.YView, 0));
                draw_sprite_ext(afterImage[i][0], afterImage[i][1], afterImage[i][3] + aiba, afterImage[i][4] + aibay, afterImage[i][2], image_yscale, 0, c_white, 1);
                shader_reset();
            }
        }
        
        if (!dFlash)
        {
            if (global.playerHp == 1)
            {
                flickerTime += 1;
                flick = 0;
                
                if (flickerTime >= flickerAt)
                {
                    shader_set(shaderPlayerRed);
                    
                    if (flickerTime >= (flickerAt + flickerDur))
                        flickerTime = 0;
                    
                    draw_sprite_ext(sprite_index, image_index, x + irandom_range(-2, 2), y + irandom_range(-1, 1), image_xscale, image_yscale, 0, c_white, image_alpha);
                    draw_sprite_ext(sprite_index, image_index, x + irandom_range(-2, 2), y + irandom_range(-1, 1), image_xscale, image_yscale, 0, c_white, image_alpha);
                    shader_reset();
                }
                else
                {
                    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
                }
            }
            else
            {
                draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
            }
        }
        
        if (global.pugLasersight)
        {
            d2wx = 0;
            d2wy = 0;
            ll = 270 + aimAngle;
            
            while (true)
            {
                if (collision_line(x, y, x + d2wx, y + d2wy, parentWall, 0, 0))
                    break;
                else if (collision_line(x, y, x + d2wx, y + d2wy, subparentEnemy, 0, 0))
                    break;
                
                d2wy += lengthdir_y(8, ll);
                d2wx += lengthdir_x(8, ll - xsp);
                
                if ((y + d2wy) > (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)))
                    break;
            }
            
            draw_line_colour(x, y + 8, x + d2wx, y + d2wy, c_red, c_red);
        }
        
        if (jetpacking)
        {
            switch (floor(jetFrame / (jetMax / 3)))
            {
                case 0:
                    jetSprite = 21;
                    break;
                
                case 1:
                    jetSprite = 22;
                    break;
                
                case 2:
                    jetSprite = 23;
                    break;
            }
            
            draw_sprite(jetSprite, jetFrame, x, y + 16);
        }
        
        if (global.gInWater)
        {
            oxyx = __view_get(e__VW.XView, 0) + 80;
            oxyy = __view_get(e__VW.YView, 0) + 104;
            oxyMetery = __view_get(e__VW.HView, 0) * (global.oxygen / 100);
            oxyBubbler = 16 * (global.oxygen / 100);
            oxyCircii = 15 - (15 * (global.oxygen / 100));
            
            if (global.oxygen > 100)
                oxyCircii = 0;
            
            draw_set_color(c_white);
            
            if (global.oxygen > 0)
            {
                if (oxyGetStun)
                {
                    oxySpr = 726;
                    oxyGetStun -= 1;
                    
                    if (oxyCircii > 0)
                        oxyCircii -= 1;
                }
                else
                {
                    oxySpr = 725;
                }
                
                draw_sprite(oxySpr, oxyCircii, x, y - 4);
            }
        }
        
        if (global.comboCount >= 5)
            drawComboNumber(x, y - 11, global.comboCount);
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
