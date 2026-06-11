function scrTouchButtonsBegin()
{
    if (global.isTablet)
    {
        if (!global.isAndroidTablet)
        {
            updateOrientation = 0;
            
            switch (display_get_orientation())
            {
                case 0:
                case 2:
                    if (global.tabletOrientation != 0)
                    {
                        global.tabletOrientation = 0;
                        updateOrientation = 1;
                    }
                    
                    break;
                
                case 1:
                    if (global.tabletOrientation != 1)
                    {
                        global.tabletOrientation = 1;
                        updateOrientation = 1;
                    }
                    
                    break;
            }
            
            if (updateOrientation)
            {
                if (global.tabletOrientation == 0)
                {
                    leftEnd = -78;
                    rightEnd = 64;
                    hbs = 32;
                    ubs = 32;
                    betweenRightAndUp = 204 - leftEnd - rightEnd;
                    vtop = 160;
                    vbottom = 250;
                    pauseTapGap = 48;
                    leftButtonx = -108;
                    rightButtonx = leftEnd + 2;
                    upButtonx = 216;
                    buttonsy = 222;
                    spriteLeft = 386;
                    spriteRight = 388;
                    spriteJump = 391;
                }
                
                if (global.tabletOrientation == 1)
                {
                    leftEnd = 8 + global.tabletButtonAdjustx;
                    rightEnd = 64 - global.tabletButtonAdjustx;
                    ubs = 32;
                    betweenRightAndUp = 68 - global.tabletButtonAdjustx;
                    vtop = 160;
                    vbottom = 265;
                    pauseTapGap = 48;
                    leftButtonx = -22 + global.tabletButtonAdjustx;
                    rightButtonx = leftEnd + 2;
                    upButtonx = 146 - global.tabletButtonAdjustx;
                    buttonsy = 250;
                    spriteLeft = 386;
                    spriteRight = 388;
                    spriteJump = 390;
                }
            }
        }
        else if (global.isAndroidTablet)
        {
            leftEnd = 8 + global.tabletButtonAdjustx;
            rightEnd = 64 - global.tabletButtonAdjustx;
            ubs = 32;
            betweenRightAndUp = 36 - global.tabletButtonAdjustx;
            vtop = 160;
            vbottom = 280;
            pauseTapGap = 32;
            leftButtonx = -22 + global.tabletButtonAdjustx;
            rightButtonx = leftEnd + 2;
            upButtonx = 146 - global.tabletButtonAdjustx;
            buttonsy = 256;
            spriteLeft = 386;
            spriteRight = 388;
            spriteJump = 390;
        }
    }
    
    leftHeld = 0;
    rightHeld = 0;
    leftPressed = 0;
    rightPressed = 0;
    upHeldPressed = 0;
    upPressed = 0;
    upReleased = 0;
    vx = __view_get(e__VW.XView, 0);
    vy = 0;
    vw = __view_get(e__VW.WView, 0);
    vh = __view_get(e__VW.HView, 0);
    vbs = (0 + __view_get(e__VW.HView, 0)) - vtop;
    
    if (!global.isTablet)
    {
        rightEnd = 56;
        
        if (global.dLeft)
            rightEnd -= 10;
    }
    
    for (i = 0; i <= 8; i += 1)
    {
        mousex = device_mouse_x_to_gui(i);
        mousey = device_mouse_y_to_gui(i);
        
        if (device_mouse_check_button(i, mb_any))
        {
            if (mousex < (160 - ubs))
            {
                if (mousey > (vy + vtop) && mousey < (vy + vbottom) && i != upFinger)
                {
                    if (mousex < (0 + leftEnd))
                    {
                        global.dTouchLeft = 1;
                        leftHeld += 1;
                    }
                    else if (mousex >= (0 + leftEnd) && mousex <= (0 + leftEnd + rightEnd))
                    {
                        if (!rightHeld)
                        {
                            global.dTouchRight = 1;
                            rightHeld += 1;
                            rightFinger = i;
                        }
                    }
                }
            }
        }
        
        if (device_mouse_check_button_pressed(i, mb_any))
        {
            if (mousey > (vy + vtop) && mousey < (vy + vbottom))
            {
                if (mousex < (0 + leftEnd))
                {
                    global.dTouchLeftPressed = 1;
                    leftPressed += 1;
                }
                else if (mousex >= (0 + leftEnd) && mousex <= (0 + leftEnd + rightEnd))
                {
                    if (!rightPressed)
                    {
                        global.dTouchRightPressed = 1;
                        rightPressed += 1;
                    }
                    
                    if (global.dTouchRight && i != rightFinger)
                    {
                        global.dTouchUp = 1;
                        upPressed += 1;
                        upFinger = i;
                    }
                }
                else if (mousex > (0 + (leftEnd + rightEnd + betweenRightAndUp)))
                {
                    global.dTouchUp = 1;
                    upPressed += 1;
                    upFinger = i;
                }
            }
            else if (mousey < ((vy + vtop) - pauseTapGap))
            {
                if (!global.isPaused)
                    global.pauseInput = 1;
            }
        }
        
        if (device_mouse_check_button_released(i, mb_any))
        {
            if (i == upFinger)
            {
                global.dTouchUpRel = 1;
                upReleased += 1;
                upFinger = -1;
            }
            
            if (i == rightFinger)
                rightFinger = -1;
        }
    }
    
    if (upFinger > -1)
    {
        global.dTouchUpHeld = 1;
        upHeldPressed += 1;
    }
    
    if (leftPressed == 0)
        global.dTouchLeftPressed = 0;
    
    if (rightPressed == 0)
        global.dTouchRightPressed = 0;
    
    if (leftHeld == 0)
        global.dTouchLeft = 0;
    
    if (rightHeld == 0)
        global.dTouchRight = 0;
    
    if (upHeldPressed == 0)
        global.dTouchUpHeld = 0;
    
    if (upPressed == 0)
        global.dTouchUp = 0;
    
    if (upReleased == 0)
        global.dTouchUpRel = 0;
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
