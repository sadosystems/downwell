draw_self();
draw_set_halign(fa_center);
boxx1 = __view_get(e__VW.XView, 0);
boxy1 = __view_get(e__VW.YView, 0) + 56 + 1;
boxy1 = (__view_get(e__VW.YView, 0) + (global.g_cameraHeight / 2)) - 85;
textx = boxx1 + 6;
nameBoxy = __view_get(e__VW.YView, 0) + 34;
nameBoxy = (__view_get(e__VW.YView, 0) + (global.g_cameraHeight / 2)) - 108;

if (wfxy > 0)
    wfxy -= 1;

if (wfxx != 0)
    wfxx -= sign(wfxx);

draw_set_halign(fa_center);

if (active)
{
    cIndex += cSp;
    
    if (cIndex > (sprite_get_number(sprShopArrow) - 1))
        cIndex -= sprite_get_number(sprShopArrow);
    
    draw_set_halign(fa_center);
    draw_sprite(sprShopDesc, 0, boxx1, boxy1);
    
    if (menuState == 0)
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        menuSlctx[0] = (__view_get(e__VW.XView, 0) + 80) - 48;
        menuSlctx[1] = __view_get(e__VW.XView, 0) + 80;
        menuSlctx[2] = __view_get(e__VW.XView, 0) + 80 + 48;
        menuSlcty = boxy1 + 24 + wfxy;
        scrDrawBorderTextBlack(menuSlctx[0], menuSlcty + 24, txtExit);
        scrDrawBorderTextBlack(menuSlctx[1], menuSlcty + 24, txtBuy);
        draw_sprite(sprShopArrow, cIndex, menuSlctx[menuSelect] - wfxx, menuSlcty + 6);
    }
    else if (menuState == 1)
    {
        arrowx = ((tablex - 38) + (19 * cursorAt)) - wfxx;
        
        if (cursorAt > 0)
        {
            draw_sprite(sprShopArrow, cIndex, arrowx, y - 28);
            draw_sprite(sprShopArrowS, cursorAt, arrowx, y - 28);
        }
        else
        {
            draw_sprite_ext(sprShopArrow, cIndex, arrowx, y - 28, 1, 1, 270, c_white, 1);
        }
        
        draw_set_valign(fa_middle);
        
        if (cursorAt > 0)
        {
            if (saleUg[cursorAt][1])
            {
                draw_sprite(global.ug[saleUg[cursorAt][0]][2], 0, __view_get(e__VW.XView, 0) + 80 + wfxx, boxy1 + 36 + wfxy);
                draw_set_halign(fa_center);
                scrDrawBorderTextBlack(boxx1 + 80 + wfxx, boxy1 + 12 + wfxy, localItemName[cursorAt]);
                
                if (global.currency >= itemPrice[cursorAt])
                    scrDrawBorderTextBlack(__view_get(e__VW.XView, 0) + 80 + wfxx, boxy1 + 54 + wfxy, string(itemPrice[cursorAt]) + " G");
                else
                    scrDrawBorderTextRed(__view_get(e__VW.XView, 0) + 80 + wfxx, boxy1 + 54 + wfxy, string(itemPrice[cursorAt]) + " G");
                
                draw_set_halign(fa_center);
                draw_set_valign(fa_middle);
                scrDrawBorderTextBlack(boxx1 + 80 + wfxx, boxy1 + 72 + 8 + wfxy, localItemDesc[cursorAt]);
            }
            else
            {
                draw_set_halign(fa_center);
                scrDrawBorderTextBlack(boxx1 + 80 + wfxx, boxy1 + 12 + 24 + wfxy, txtPurchase);
            }
        }
        else
        {
            draw_set_halign(fa_center);
            scrDrawBorderTextBlack(boxx1 + 80 + wfxx, boxy1 + 12 + 24 + wfxy, txtBack);
        }
    }
    else if (menuState == 2)
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        sellSlctx[0] = (__view_get(e__VW.XView, 0) + 80) - 48;
        sellSlctx[1] = __view_get(e__VW.XView, 0) + 80;
        sellIconx[0] = (__view_get(e__VW.XView, 0) + 80) - 24;
        sellIconx[1] = __view_get(e__VW.XView, 0) + 80;
        sellIconx[2] = __view_get(e__VW.XView, 0) + 80 + 24;
        sellSlcty = boxy1 + 48 + wfxy;
        sellIcony = sellSlcty - 12;
        
        for (i = 0; i <= 2; i += 1)
            draw_sprite(sprShopSell, i, sellIconx[i], sellIcony);
        
        scrDrawBorderTextBlack(sellIconx[0], sellIcony - 20, b2hpAmt);
        scrDrawBorderTextBlack(sellIconx[2], sellIcony - 20, b2hpAmt * sellBtryPrice);
        scrDrawBorderTextBlack(sellSlctx[0], sellSlcty + 16, txtBack);
        scrDrawBorderTextBlack(sellSlctx[1], sellSlcty + 16, txtSell);
        scrDrawBorderTextBlack(sellSlctx[1], sellSlcty + 16 + 10, string(b2hpAmt));
        
        if (cursorAt == 1)
        {
            if (b2hpAmt > 1)
                draw_sprite_ext(sprShopArrow, cIndex, sellSlctx[1] - 20, sellSlcty + 30, 1, 1, 270, c_white, 1);
            
            draw_sprite_ext(sprShopArrow, cIndex, sellSlctx[1] + 20, sellSlcty + 30, 1, 1, 90, c_white, 1);
        }
        
        draw_sprite(sprShopArrow, cIndex, sellSlctx[cursorAt] - wfxx, sellSlcty + 4);
    }
}

if (!global.criminal)
    scrCheckThisDraw();

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
