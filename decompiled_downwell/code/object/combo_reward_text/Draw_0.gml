if (!global.lowSpec)
{
    if (surface_exists(global.surfaceFx))
    {
        surface_set_target(global.surfaceFx);
        
        if (drawing)
        {
            stWidth = 40;
            xxx = 0 + relativex;
            yyy = -__view_get(e__VW.YView, 0) + relativey;
            
            if (yyy > 80)
                yyy = 80;
            
            overXview = (xxx + (stWidth / 2)) - (0 + __view_get(e__VW.WView, 0));
            underXview = xxx - (stWidth / 2) - 0;
            
            if (overXview > -10)
                xxx = xxx - overXview - 10;
            else if (underXview < 10)
                xxx = xxx + -underXview + 10;
            
            if (drawing)
            {
                drawComboExc(xxx, yyy - 13, comboNum);
                
                if (showBonus >= 1)
                {
                    draw_sprite(sprComboReward, 0, xxx, yyy);
                    
                    if (powanReward > 0)
                        powanReward -= 1;
                }
                
                if (showBonus >= 2)
                {
                    cNumy = yyy + 12 + powanGem;
                    draw_sprite(sprComboNumber, 10, xxx - 12, cNumy);
                    draw_sprite(sprComboNumber, 1, xxx - 6, cNumy);
                    draw_sprite(sprComboNumber, 0, xxx - 0, cNumy);
                    draw_sprite(sprComboNumber, 0, xxx + 6, cNumy);
                    draw_sprite(sprComboNumber, 11, xxx + 13, cNumy);
                    
                    if (powanGem > 0)
                        powanGem -= 1;
                }
                
                if (showBonus >= 3)
                {
                    cNumy = yyy + 12 + powanBtry + 7;
                    draw_sprite(sprComboNumber, 10, xxx - 6, cNumy);
                    draw_sprite(sprComboNumber, 1, xxx - 0, cNumy);
                    draw_sprite(sprComboNumber, 12, xxx + 6, cNumy);
                    
                    if (powanBtry > 0)
                        powanBtry -= 1;
                }
                
                if (showBonus >= 4)
                {
                    cNumy = yyy + 12 + powanHP + 7 + 7;
                    draw_sprite(sprComboNumber, 10, xxx - 6, cNumy);
                    draw_sprite(sprComboNumber, 1, xxx - 0, cNumy);
                    draw_sprite(sprComboNumber, 13, xxx + 6, cNumy);
                    
                    if (powanHP > 0)
                        powanHP -= 1;
                }
                
                if (flashFrame < 8)
                {
                    draw_sprite(sprSuperFlash, flashFrame, xxx - 1, yyy - 13);
                    flashFrame += 0.75;
                }
            }
        }
        
        surface_reset_target();
    }
}
else
{
    stWidth = 40;
    xxx = __view_get(e__VW.XView, 0) + relativex;
    yyy = relativey;
    
    if (yyy > (__view_get(e__VW.YView, 0) + 112))
        yyy = __view_get(e__VW.YView, 0) + 112;
    
    overXview = (xxx + (stWidth / 2)) - (__view_get(e__VW.XView, 0) + __view_get(e__VW.WView, 0));
    underXview = xxx - (stWidth / 2) - __view_get(e__VW.XView, 0);
    
    if (overXview > -10)
        xxx = xxx - overXview - 10;
    else if (underXview < 10)
        xxx = xxx + -underXview + 10;
    
    if (drawing)
    {
        drawComboExc(xxx, yyy - 13, comboNum);
        
        if (showBonus >= 1)
        {
            draw_sprite(sprComboReward, 0, xxx, yyy);
            
            if (powanReward > 0)
                powanReward -= 1;
        }
        
        if (showBonus >= 2)
        {
            cNumy = yyy + 12 + powanGem;
            draw_sprite(sprComboNumber, 10, xxx - 12, cNumy);
            draw_sprite(sprComboNumber, 1, xxx - 6, cNumy);
            draw_sprite(sprComboNumber, 0, xxx - 0, cNumy);
            draw_sprite(sprComboNumber, 0, xxx + 6, cNumy);
            draw_sprite(sprComboNumber, 11, xxx + 13, cNumy);
            
            if (powanGem > 0)
                powanGem -= 1;
        }
        
        if (showBonus >= 3)
        {
            cNumy = yyy + 12 + powanBtry + 7;
            draw_sprite(sprComboNumber, 10, xxx - 6, cNumy);
            draw_sprite(sprComboNumber, 1, xxx - 0, cNumy);
            draw_sprite(sprComboNumber, 12, xxx + 6, cNumy);
            
            if (powanBtry > 0)
                powanBtry -= 1;
        }
        
        if (showBonus >= 4)
        {
            cNumy = yyy + 12 + powanHP + 7 + 7;
            draw_sprite(sprComboNumber, 10, xxx - 6, cNumy);
            draw_sprite(sprComboNumber, 1, xxx - 0, cNumy);
            draw_sprite(sprComboNumber, 13, xxx + 6, cNumy);
            
            if (powanHP > 0)
                powanHP -= 1;
        }
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
