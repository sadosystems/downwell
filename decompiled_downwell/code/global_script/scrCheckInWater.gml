function scrCheckInWater()
{
    if (place_meeting(xx, yy, parentWater))
    {
        if (!global.gInWater)
        {
            with (objControlerN)
                alarm[2] = 90;
            
            breath = -15;
            alarm[8] = 1;
            inWater = 1;
            global.gInWater = 1;
            sp = 0;
            
            while (place_meeting(xx, yy - sp, parentWater))
                sp += 1;
            
            repeat (24)
                instance_create(xx + choose(-2, -1, 0, 1, 2), yy - sp, fxSplash);
            
            soundPlayOL(307, 85, 0, 1, "waterThings");
            
            if (ysp > 0.5)
                ysp = 0.5;
        }
    }
    else
    {
        if (global.gInWater)
        {
            repeat (24)
            {
                with (instance_create(xx + choose(-2, -1, 0, 1, 2), yy, fxSplash))
                    ysp = random(3);
            }
            
            if (!global.death)
                soundPlayOL(1, 85, 0, 1, "waterThings");
            
            inWater = 0;
            global.gInWater = 0;
            wet = 0;
            alarm[4] = 1;
        }
        
        global.gInWater = 0;
    }
}
