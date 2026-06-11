bgmGain = 1;

if (global.gInWater)
    bgmGain = 0.7;

if (state == 0)
{
    if (collision_rectangle(x - 80, y, x + 80, y + 32, objPlayer_n, 0, 0))
    {
        if (alive)
            scrTypicalDamage(1, 3, 2);
        
        scrFjump(0, 5);
        
        if (state == 0 && !global.death)
            movesp = 2;
    }
}
else if (collision_circle(x, y + 48, 48, objPlayer_n, 1, 0))
{
    if (alive)
        scrTypicalDamage(1, 3, 2);
    
    scrFjump(0, 5);
    
    if (state == 0 && !global.death)
        movesp = 2;
}

if (global.fightStarted)
{
    if (global.ply > (y + 48))
    {
        if (alive)
            scrTypicalDamage(1, 3, 2);
        
        scrFjump(0, 3);
    }
    
    if (image_speed != imgSp)
        image_speed = imgSp;
    
    if (active)
    {
        if (hit && !bulletImmune)
        {
            hit = 0;
            direction = hitDir;
            accumDamage += hitDmg;
            hitDmg = 0;
            
            if (state == 0)
            {
                if (movesp < 1.25)
                    movesp = 1.25;
                
                powan += 8;
                
                if (powan > 28)
                    powan = 28;
                
                if (accumDamage >= ouchAmt)
                {
                    movesp = 3.5;
                    accumDamage -= ouchAmt;
                    scrSShake(4, 45);
                    state = 2;
                    soundPlayOL(203, 50, 0, 1, "boss");
                    
                    repeat (4)
                        emitSmoke(x, y, 90 + random_range(-45, 45), random_range(2, 5));
                    
                    image_index = 0;
                    alarm[4] = 75;
                }
            }
            
            soundPlayOL(208, 50, 0, 1, "boss");
            
            if (state == 0)
            {
                hitStun = 1;
                alarm[0] = 3;
            }
        }
        
        if (state != 1)
        {
            if (alive)
                global.bossDead = 0;
            
            stateBackSprite = 670;
            stateFrontSprite = 671;
            
            if (state == 0)
                bulletImmune = 0;
            else
                bulletImmune = 1;
            
            if (ehp <= (ehpMax - threshold))
            {
                state = 1;
                spawnArea += 1;
                soundPlayOL(207, 50, 0, 1, "boss");
                
                if (spawnArea >= 5)
                    alive = 0;
                
                movesp = 3.5;
                stopped = 0;
                alarm[2] = 960;
                alarm[5] = 300;
                slowDown = 0;
                alarm[3] = 720;
                ehp = ehpMax;
            }
            
            if (!opening)
            {
                if (movesp > 1)
                    movesp -= dcclamt;
                
                if (movesp > -maxsp)
                    movesp -= 0.05;
            }
            else
            {
                movesp *= 0.975;
            }
            
            if (state == 2)
            {
                if (alarm[4] > 0 && alarm[4] < 45)
                {
                    stateBackSprite = 672;
                    stateFrontSprite = 673;
                    image_speed = 0.5 - (alarm[4] / 100);
                }
                else
                {
                    stateBackSprite = 672;
                    stateFrontSprite = 676;
                    
                    if (image_index > 1)
                        image_speed = 0;
                }
            }
            
            maxsp = 0.2;
            
            if (opening)
                maxsp = 0;
        }
        else if (state == 1)
        {
            stateBackSprite = 672;
            stateFrontSprite = 672;
            scrSShake(2, 2);
            camMain.camShakeAmt = shakeAmt;
            global.bossDead = 1;
            bgmGain *= 1;
            
            if (!myRumble && alive)
                myRumble = soundPlayOL(211, 80, 1, 1, "boss");
            
            bulletImmune = 1;
            
            if (!stopped)
            {
                if (movesp < 0)
                    stopped = 1;
                
                if (movesp > 1)
                    movesp -= dcclamt;
                
                if (movesp > -maxsp)
                    movesp -= 0.05;
            }
            else
            {
                maxsp = 2.6;
                
                if (slowDown)
                    maxsp = 0;
                
                if (movesp > maxsp)
                    movesp -= dcclamt;
                
                if (movesp < maxsp)
                    movesp += 0.0125;
            }
        }
        
        ysp = movesp;
        
        if (opening)
        {
            if (ysp < 0)
                ysp = 0;
            
            bulletImmune = 1;
        }
        
        xx = room_width / 2;
        yy += ysp;
    }
    else
    {
        alarmStop(10);
    }
    
    x = round(xx);
    y = round(yy);
    
    if (hitStun)
    {
        backSprite = 668;
        frontSprite = 668;
    }
    else
    {
        backSprite = stateBackSprite;
        frontSprite = stateFrontSprite;
    }
    
    if (ehp <= 0)
        alive = 0;
    
    if (!alive)
    {
        global.bossDead = 2;
        frontSprite = 678;
        backSprite = 678;
        
        if (audio_is_playing(global.bgm))
            audio_stop_sound(global.bgm);
        
        if (endExplosion == -1)
        {
            endExplosion = 0;
            alarm[11] = 30;
            
            with (objBuilder)
                scrBossPat5();
            
            with (myTentacle)
            {
                active = 0;
                
                repeat (5)
                    instance_create(x, y, bulletExplosion1);
                
                instance_destroy();
            }
            
            soundPlayOL(206, 90, 0, 1, "boss");
        }
    }
}
else if (hit)
{
    global.fightStarted = 1;
    opening = 1;
    movesp = 0.8;
    hit = 0;
    hitStun = 0;
    ehp = ehpMax;
    accumDamage = 0;
    scrSShake(2, 20);
    soundPlayOL(224, 50, 0, 1, "boss");
    alarm[9] = 240;
    alarm[2] = 456;
    alarm[10] = alarm[2] + 60;
    alarm[1] = alarm[2] + 240;
    alarm[8] = alarm[2] + 180;
    alarm[6] = alarm[2] + 300;
    alarm[7] = alarm[2] + 300;
}

if (opening == 2)
{
    if (growlShake)
        scrSShake(growlShake, 2);
}

if (audio_is_playing(global.bgm))
    audio_sound_gain(global.bgm, bgmGain, 100);
