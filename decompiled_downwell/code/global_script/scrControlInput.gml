function scrControlInput()
{
    global.padUp = gamepad_button_check_pressed(0, gp_face1);
    global.padUpHeld = gamepad_button_check(0, gp_face1);
    global.padUpRel = gamepad_button_check_released(0, gp_face1);
    global.padCancel = gamepad_button_check_pressed(0, gp_face2);
    
    if (global.isPaused || global.death)
    {
        if (!global.padLeft && !global.padRight)
        {
            padLeftPressed = gamepad_button_check_pressed(0, gp_padl) || gamepad_button_check_pressed(0, gp_padu);
            padRightPressed = gamepad_button_check_pressed(0, gp_padr) || gamepad_button_check_pressed(0, gp_padd);
        }
        else
        {
            padLeftPressed = 0;
            padRightPressed = 0;
        }
        
        global.padLeft = gamepad_button_check(0, gp_padl) || gamepad_button_check(0, gp_padu);
        global.padRight = gamepad_button_check(0, gp_padr) || gamepad_button_check(0, gp_padd);
        
        if (gamepad_axis_value(0, gp_axislh) != 0)
        {
            if (gamepad_axis_value(0, gp_axislh) > 0)
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
        else if (gamepad_axis_value(0, gp_axislv) != 0)
        {
            if (gamepad_axis_value(0, gp_axislv) > 0)
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
        global.padLeft = gamepad_button_check(0, gp_padl);
        padLeftPressed = gamepad_button_check_pressed(0, gp_padl);
        global.padRight = gamepad_button_check(0, gp_padr);
        padRightPressed = gamepad_button_check_pressed(0, gp_padr);
        
        if (gamepad_axis_value(0, gp_axislh) != 0)
        {
            if (gamepad_axis_value(0, gp_axislh) > 0)
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
    
    global.dUp = keyboard_check_pressed(vk_space) || global.padUp || global.dTouchUp || vkUpPressed;
    global.dUpHeld = keyboard_check(vk_space) || global.padUpHeld || global.dTouchUpHeld || vkUpHeld;
    global.dUpRel = keyboard_check_released(vk_space) || global.padUpRel || global.dTouchUpRel || vkUpReleased;
    global.dLeft = keyboard_check(ord("A")) || keyboard_check(ord("Q")) || global.padLeft || global.dTouchLeft || vkLeftHeld;
    global.dLeftPressed = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(ord("Q")) || padLeftPressed || global.dTouchLeftPressed || vkLeftPressed;
    global.dRight = keyboard_check(ord("D")) || global.padRight || global.dTouchRight || vkRightHeld;
    global.dRightPressed = keyboard_check_pressed(ord("D")) || padRightPressed || global.dTouchRightPressed || vkRightPressed;
    global.anyInput = global.dUp || global.dLeftPressed || global.dRightPressed;
    vkLeftPressed = 0;
    vkRightPressed = 0;
    vkUpPressed = 0;
    vkUpReleased = 0;
}
