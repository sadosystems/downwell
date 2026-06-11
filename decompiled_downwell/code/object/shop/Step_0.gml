with (Shop)
{
    if (global.pTimeStop)
    {
        if (!global.death)
        {
            if (!shopBgm)
            {
                if (point_distance(x, y, global.plx, global.ply) < 160)
                    shopBgm = 1;
            }
            
            if (shopBgm)
            {
                if (scrInView(0, 0, 0))
                    audio_sound_gain(radio, 1, 100);
                else
                    audio_sound_gain(radio, 0.3, 100);
                
                if (global.noBgm)
                    audio_sound_gain(radio, 0, 100);
                else if (audio_is_paused(radio))
                    audio_resume_sound(radio);
            }
        }
    }
    else if (shopBgm)
    {
        audio_sound_gain(radio, 0, 0);
        shopBgm = 0;
    }
    
    if (!global.criminal)
    {
        if (!speaking)
        {
            if (place_meeting(xx, yy, objPlayer_n) && global.interactable)
            {
                if (global.dUp)
                {
                    if (global.plx > xx)
                        objPlayer_n.image_xscale = -1;
                    else
                        objPlayer_n.image_xscale = 1;
                    
                    speaking = 1;
                    active = 1;
                    global.noControl = 1;
                    cursorAt = 1;
                    menuSelect = 1;
                    keeper.thankful = 0;
                    keeper.goodbye = 0;
                    menuState = 1;
                    
                    switch (choose(1, 2, 3))
                    {
                        case 1:
                            scrRisingTextShop(msgx, keeper.y - 18, logWelcome);
                            soundPlayOL(101, 90, 0, 1, "merchant");
                            break;
                        
                        case 2:
                            scrRisingTextShop(msgx, keeper.y - 18, logHello);
                            soundPlayOL(95, 90, 0, 1, "merchant");
                            break;
                        
                        case 3:
                            scrRisingTextShop(msgx, keeper.y - 18, logHoho);
                            soundPlayOL(96, 90, 0, 1, "merchant");
                            break;
                    }
                    
                    global.dUp = 0;
                }
            }
        }
        else
        {
            leave = 1;
        }
        
        if (active)
        {
            if (menuState == 0)
            {
                if (global.dRightPressed)
                {
                    if (menuSelect < 1)
                        menuSelect += 1;
                    else
                        menuSelect = 0;
                    
                    soundPlayOL(109, 90, 0, 1, "UI");
                    wfxx = 6;
                }
                
                if (global.dLeftPressed)
                {
                    if (menuSelect > 0)
                        menuSelect -= 1;
                    else
                        menuSelect = 1;
                    
                    soundPlayOL(109, 90, 0, 1, "UI");
                    wfxx = -6;
                }
                
                if (global.dUp)
                {
                    if (menuSelect > 0)
                    {
                        menuState = menuSelect;
                        soundPlayOL(107, 90, 0, 1, "UI");
                    }
                    else
                    {
                        exitShop = 1;
                        
                        if (thank)
                        {
                            scrRisingTextShop(msgx, keeper.y - 18, logThank);
                            soundPlayOL(99, 90, 0, 1, "merchant");
                            thank = 0;
                            keeper.goodbye = 1;
                            keeper.image_index = 0;
                        }
                        else
                        {
                            soundPlayOL(108, 90, 0, 1, "UI");
                        }
                    }
                    
                    cursorAt = 1;
                    global.dUp = 0;
                }
            }
            
            if (menuState == 1)
            {
                if (global.dRightPressed)
                {
                    if (cursorAt < 3)
                        cursorAt += 1;
                    else
                        cursorAt = 0;
                    
                    soundPlayOL(109, 90, 0, 1, "UI");
                    wfxx = 6;
                }
                
                if (global.dLeftPressed)
                {
                    if (cursorAt > 0)
                        cursorAt -= 1;
                    else
                        cursorAt = 3;
                    
                    soundPlayOL(109, 90, 0, 1, "UI");
                    wfxx = -6;
                }
                
                if (global.dUp)
                {
                    if (cursorAt == 0)
                    {
                        exitShop = 1;
                        
                        if (thank)
                        {
                            scrRisingTextShop(msgx, keeper.y - 18, logThank);
                            soundPlayOL(99, 90, 0, 1, "merchant");
                            thank = 0;
                            keeper.goodbye = 1;
                            keeper.image_index = 0;
                        }
                        else
                        {
                            soundPlayOL(108, 90, 0, 1, "UI");
                        }
                    }
                    else if (cursorAt > 0)
                    {
                        if (saleUg[cursorAt][1] > 0)
                        {
                            if (global.currency >= itemPrice[cursorAt])
                            {
                                thank = 1;
                                saleUg[cursorAt][1] -= 1;
                                scrGainUg(saleUg[cursorAt][0]);
                                global.currency -= itemPrice[cursorAt];
                                
                                if (saleUg[cursorAt][1] == 0)
                                {
                                    glassCase[cursorAt].storedItem = 0;
                                    
                                    with (casedItem[cursorAt])
                                        instance_destroy();
                                }
                                
                                keeper.thankful = 1;
                                keeper.image_index = 0;
                                scrRisingTextShop(msgx, keeper.y - 18, logMaido);
                                soundPlayOL(104, 90, 0, 1, "merchant");
                                soundPlayOL(105, 50, 0, 1, "UI");
                            }
                            else
                            {
                                scrRisingTextShop(msgx, keeper.y - 18, logPoor);
                                soundPlayOL(100, 90, 0, 1, "merchant");
                                keeper.confused = 1;
                                keeper.image_index = 0;
                            }
                        }
                        else
                        {
                            switch (choose(1, 2, 3))
                            {
                                case 1:
                                    scrRisingTextShop(msgx, keeper.y - 18, "?");
                                    soundPlayOL(98, 90, 0, 1, "merchant");
                                    break;
                                
                                case 2:
                                    scrRisingTextShop(msgx, keeper.y - 18, logWhat);
                                    soundPlayOL(102, 90, 0, 1, "merchant");
                                    break;
                                
                                case 3:
                                    scrRisingTextShop(msgx, keeper.y - 18, logHuh);
                                    soundPlayOL(97, 90, 0, 1, "merchant");
                                    break;
                            }
                            
                            keeper.confused = 1;
                            keeper.image_index = 0;
                        }
                    }
                    
                    global.padCancel = 0;
                }
                
                if (global.padCancel)
                {
                    exitShop = 1;
                    
                    if (thank)
                    {
                        scrRisingTextShop(msgx, keeper.y - 18, logThank);
                        soundPlayOL(99, 90, 0, 1, "merchant");
                        thank = 0;
                        keeper.goodbye = 1;
                        keeper.image_index = 0;
                    }
                    else
                    {
                        soundPlayOL(108, 90, 0, 1, "UI");
                    }
                }
            }
        }
        
        if (x > __view_get(e__VW.XView, 0) && x < (__view_get(e__VW.XView, 0) + __view_get(e__VW.WView, 0)) && y > __view_get(e__VW.YView, 0) && y < (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)))
        {
            if (!shopInView)
            {
                shopInView = 1;
                soundPlayOL(103, 90, 0, 1, "merchant");
            }
        }
        else if (shopInView)
        {
            shopInView = 0;
        }
        
        if (shopInView)
        {
            if (global.plx > keeperx)
            {
                if (!keeperAngry)
                {
                    keeperAngry = 1;
                    soundPlayOL(94, 90, 0, 1, "merchant");
                }
            }
            else if (keeperAngry)
            {
                keeperAngry = 0;
            }
        }
    }
    
    if (global.criminal || global.death)
    {
        if (active)
            active = 0;
        
        if (!leave)
            leave = 1;
        
        mask_index = noMask;
    }
    
    if (exitShop)
    {
        active = 0;
        global.noControl = 0;
        leave = 0;
        speaking = 0;
        menuSelect = 0;
        menuState = 0;
        exitShop = 0;
    }
    
    scrCheckThisSignStep();
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
