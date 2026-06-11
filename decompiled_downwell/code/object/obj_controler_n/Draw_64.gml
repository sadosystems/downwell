if (global.shaderType <= global.shaderArMax)
{
    shader_set(global.shaderAr[global.shaderType][0]);
    
    if (global.isPC || global.isTablet)
    {
        if (global.disp4x3)
        {
            if (!global.lowSpec && !global.isPC)
                draw_sprite_stretched(mask32, 0, -300, 0, 1000, 300);
            
            if (global.isPC)
            {
                if (global.pcbgNum > 0)
                    draw_sprite(global.pcbg[global.pcbgNum], 0, -110, 0);
            }
            
            draw_sprite(sprTabletBorder, 0, -2, 0);
            draw_sprite_ext(sprTabletBorder, 0, 162, 0, -1, 1, 0, c_white, 1);
            
            if (global.isTablet)
                drawTouchButtonsTabletBack();
            
            if (!global.lowSpec && !global.isAndroid)
                scrDrawHud4x3();
        }
    }
    
    draw_set_valign(fa_top);
    
    if (os_type == os_ios)
    {
        draw_surface_stretched(application_surface, 0, 0, 160, 284);
    }
    else
    {
        if (global.tateRotation == 1)
        {
            ASAngle = 0;
            ASx = 0;
            ASy = 0;
            ASxs = 1;
            ASys = 1;
        }
        else if (global.tateRotation == 2)
        {
            ASAngle = 90;
            ASx = -172;
            ASy = 284;
            ASxs = global.windowHeight / global.windowWidth;
            ASys = global.windowWidth / global.windowHeight;
        }
        else if (global.tateRotation == 3)
        {
            ASAngle = 270;
            ASx = 332;
            ASy = 0;
            ASxs = global.windowHeight / global.windowWidth;
            ASys = global.windowWidth / global.windowHeight;
        }
        else
        {
            ASAngle = 0;
            ASx = 0;
            ASy = 0;
            ASxs = 1;
            ASys = 1;
        }
        
        draw_surface_ext(application_surface, ASx, ASy, ASys, ASys, ASAngle, c_white, 1);
    }
    
    shader_reset();
}
else
{
    global.shaderType = 0;
}

if (global.showSplash)
{
    draw_set_color(c_black);
    
    if (global.showSplash < 6)
        draw_rectangle(-300, 0, 460, 400, 0);
    
    switch (global.showSplash)
    {
        case 1:
            break;
        
        case 2:
            draw_sprite(sprDevolverLogo, 0, 80, 140);
            break;
        
        case 3:
            draw_set_halign(fa_center);
            
            if (global.disp4x3)
            {
                ojiroTextx = 80;
                ojiroTexty = 130;
                eirikTextx = 168;
                eirikTexty = 200;
                joonasTextx = -8;
                joonasTexty = 200;
            }
            else
            {
                ojiroTextx = 80;
                ojiroTexty = 100;
                eirikTextx = 80;
                eirikTexty = ojiroTexty + 50;
                joonasTextx = 80;
                joonasTexty = ojiroTexty + 50 + 40;
            }
            
            scrDrawBorderTextBlack(ojiroTextx, ojiroTexty, "a game by#OJIRO FUMOTO");
            scrDrawBorderTextRed(ojiroTextx, ojiroTexty + 10 + 10, "@MOPPIN_");
            scrDrawBorderTextBlack(eirikTextx, eirikTexty, "EIRIK SUHRKE");
            scrDrawBorderTextRed(eirikTextx, eirikTexty + 10, "@STROTCHY");
            scrDrawBorderTextBlack(joonasTextx, joonasTexty, "JOONAS TURNER");
            scrDrawBorderTextRed(joonasTextx, joonasTexty + 10, "@KISSAKOLME");
            splashDithFrame = 11;
            break;
        
        case 4:
            draw_sprite(sprControls, 0, 80, 140);
            splashDithFrame = 11;
            break;
        
        case 5:
            draw_sprite(sprControls, 0, 80, 140);
            draw_sprite_tiled(sprDitherFade, splashDithFrame, -300, 0);
            
            if (splashDithFrame >= 1)
                splashDithFrame -= 0.3;
            
            break;
        
        case 6:
            draw_sprite_tiled(sprDitherFade, splashDithFrame, -300, 0);
            
            if (splashDithFrame <= 11)
                splashDithFrame += 0.3;
    }
}

if (global.debugMode)
    scrDrawBorderTextBlack(16, 16, "debug#" + string(global.g_cameraHeight) + " " + string(__view_get(e__VW.YView, 0)));

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
