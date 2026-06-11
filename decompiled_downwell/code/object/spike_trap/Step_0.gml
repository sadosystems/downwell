if (!global.pTimeStop)
{
    if (global.hardSpikeActivate)
        activated = 1;
    
    if (!allSet)
    {
        if (place_meeting(x + 16, y, spikeTrap))
        {
            if (place_meeting(x - 16, y, spikeTrap))
                image_index = 1;
            else
                image_index = 0;
        }
        else if (place_meeting(x - 16, y, spikeTrap))
        {
            image_index = 2;
        }
        else
        {
            image_index = 3;
        }
        
        if (image_index == 0 || image_index == 3 || rusty)
        {
            if (!rusty)
            {
                switch (global.level)
                {
                    case 1:
                        rusty = choose(0, 1, 1);
                        break;
                    
                    case 2:
                        rusty = choose(0, 0, 0, 0, 1);
                        break;
                    
                    case 3:
                        rusty = 0;
                        break;
                }
            }
            
            if (global.hardMode)
                rusty = 0;
            
            if (global.area == 5)
                rusty = 0;
            
            if (rusty)
            {
                sprite_index = sprSpikeTrapRusty;
                target = instance_place(x + 16, y, spikeTrap);
                
                if (target)
                {
                    with (target)
                    {
                        rusty = 1;
                        sprite_index = sprSpikeTrapRusty;
                        allSet = 0;
                    }
                }
            }
        }
        
        if (rusty)
            rusty = choose(2, 2, 2, 2, 3);
        
        allSet = 1;
    }
    
    if (!spikeOut)
    {
        if (place_meeting(x, y - 2, objPlayer_n))
        {
            if (objPlayer_n.grounded)
            {
                if (!global.hardMode)
                    activated = 1;
            }
        }
        
        if (activated)
        {
            if (!rusty || rusty == 3)
            {
                spikeOut = 1;
                spikeImage = 4;
                
                if (!rusty)
                    alarm[0] = 30;
                
                soundPlay(190, 80, 0, 1);
                emitMovingFx(x, y - 6, 96, 0.7, 0, 0);
                activated = 0;
            }
        }
    }
    else
    {
        if (spikeOut == 2)
        {
            if (spikeImage < 7)
            {
                spikeImage += 0.3;
                
                if (!shink)
                {
                    if (spikeImage > 5.5)
                    {
                        soundPlay(189, 80, 0, 1);
                        bgmDuck(50, 0.3);
                        shink = 1;
                    }
                }
            }
            else
            {
                spikeOut = 3;
                shink = 0;
                alarm[1] = 30;
            }
        }
        
        if (spikeOut == 4)
        {
            if (spikeImage > 3)
                spikeImage -= 0.5;
            
            if (spikeImage < 4)
                spikeOut = 0;
        }
        
        if (spikeImage > 5)
        {
            if (collision_rectangle(x - 7, y - 8, x + 7, y - 16, objPlayer_n, 0, 0))
                scrTypicalDamage(global.spikeDmg, 3, 2);
        }
    }
}
else
{
    alarmStop(2);
}

wallHp = 100;
