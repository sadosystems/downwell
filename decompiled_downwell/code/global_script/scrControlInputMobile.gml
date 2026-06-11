function scrControlInputMobile()
{
    for (i = 0; i <= 1; i += 1)
    {
        global.padUp = gamepad_button_check_pressed(i, gp_face1);
        iosGamepad = i;
    }
    
    if (iosGamepad >= 0)
    {
        global.padUp = gamepad_button_check_pressed(iosGamepad, gp_face1);
        global.padUpHeld = gamepad_button_check(iosGamepad, gp_face1);
        global.padUpRel = gamepad_button_check_released(iosGamepad, gp_face1);
        global.padCancel = gamepad_button_check_pressed(iosGamepad, gp_face2);
        
        if (global.isPaused || global.death)
        {
            if (!global.padLeft && !global.padRight)
            {
                padLeftPressed = gamepad_button_check_pressed(iosGamepad, gp_padl) || gamepad_button_check_pressed(iosGamepad, gp_padu);
                padRightPressed = gamepad_button_check_pressed(iosGamepad, gp_padr) || gamepad_button_check_pressed(iosGamepad, gp_padd);
            }
            else
            {
                padLeftPressed = 0;
                padRightPressed = 0;
            }
            
            global.padLeft = gamepad_button_check(iosGamepad, gp_padl) || gamepad_button_check(iosGamepad, gp_padu);
            global.padRight = gamepad_button_check(iosGamepad, gp_padr) || gamepad_button_check(iosGamepad, gp_padd);
            
            if (gamepad_axis_value(iosGamepad, gp_axislh) != 0)
            {
                if (gamepad_axis_value(iosGamepad, gp_axislh) > 0)
                {
                    global.padRight = 1;
                    
                    if (!analogPressed)
                    {
                        padRightPressed = 1;
                        analogPressed = 1;
                    }
                }
                else
                {
                    global.padLeft = 1;
                    
                    if (!analogPressed)
                    {
                        padLeftPressed = 1;
                        analogPressed = 1;
                    }
                }
            }
            else if (gamepad_axis_value(iosGamepad, gp_axislv) != 0)
            {
                if (gamepad_axis_value(iosGamepad, gp_axislv) > 0)
                {
                    global.padRight = 1;
                    
                    if (!analogPressed)
                    {
                        padRightPressed = 1;
                        analogPressed = 1;
                    }
                }
                else
                {
                    global.padLeft = 1;
                    
                    if (!analogPressed)
                    {
                        padLeftPressed = 1;
                        analogPressed = 1;
                    }
                }
            }
            else
            {
                analogPressed = 0;
            }
        }
        else
        {
            global.padLeft = gamepad_button_check(iosGamepad, gp_padl);
            padLeftPressed = gamepad_button_check_pressed(iosGamepad, gp_padl);
            global.padRight = gamepad_button_check(iosGamepad, gp_padr);
            padRightPressed = gamepad_button_check_pressed(iosGamepad, gp_padr);
            
            if (gamepad_axis_value(iosGamepad, gp_axislh) != 0)
            {
                if (gamepad_axis_value(iosGamepad, gp_axislh) > 0)
                {
                    global.padRight = 1;
                    
                    if (!analogPressed)
                    {
                        padRightPressed = 1;
                        analogPressed = 1;
                    }
                }
                else
                {
                    global.padLeft = 1;
                    
                    if (!analogPressed)
                    {
                        padLeftPressed = 1;
                        analogPressed = 1;
                    }
                }
            }
            else
            {
                analogPressed = 0;
            }
        }
    }
    
    global.dUp = global.dTouchUp || global.padUp;
    global.dUpHeld = global.dTouchUpHeld || global.padUpHeld;
    global.dUpRel = global.dTouchUpRel || global.padUpRel;
    global.dLeft = global.dTouchLeft || global.padLeft;
    global.dLeftPressed = global.dTouchLeftPressed || padLeftPressed;
    global.dRight = global.dTouchRight || global.padRight;
    global.dRightPressed = global.dTouchRightPressed || padRightPressed;
    global.anyInput = global.dUp || global.dLeftPressed || global.dRightPressed;
    vkLeftPressed = 0;
    vkRightPressed = 0;
    vkUpPressed = 0;
    vkUpReleased = 0;
}
