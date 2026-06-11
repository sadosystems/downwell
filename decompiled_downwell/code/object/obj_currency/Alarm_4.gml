if (!attracted)
{
    if (TimeStopBound())
    {
        if (image_speed != imgSp)
            image_speed = imgSp;
        
        if (!attracted || !suckable)
        {
            if (ysp < -1)
                ysp += ugravhard;
            else
                ysp += ugrav;
            
            scrCheckCollisionWith(87);
            
            if (ycollision != 0)
            {
                if (ycollision == 1)
                {
                    if (!place_meeting(xx, yy, parentThinwall))
                    {
                        if (ysp <= 0)
                            ysp *= 0;
                        else
                            ysp = irandom_range(-0.5, -1.2);
                        
                        xsp *= 0.7;
                        
                        if (yy > __view_get(e__VW.YView, 0))
                            mySound = soundPlay(bounceSnd, 30, 0, 1);
                        
                        if (audio_is_playing(mySound))
                            audio_sound_gain(mySound, bounceGain, 0);
                        
                        bounceGain *= 0.7;
                    }
                }
            }
            
            scrCheckCollisionWith(57);
            
            if (xcollision != 0)
            {
                xsp *= -1;
                xsp *= 0.7;
            }
            
            if (ycollision != 0)
            {
                if (ysp <= 0)
                    ysp *= 0;
                else
                    ysp = irandom_range(-0.5, -1.2);
                
                xsp *= 0.7;
                
                if (yy > __view_get(e__VW.YView, 0))
                    mySound = soundPlay(bounceSnd, 30, 0, 1);
                
                if (audio_is_playing(mySound))
                    audio_sound_gain(mySound, bounceGain, 0);
                
                bounceGain *= 0.7;
            }
            
            if (abs(xsp) < 0.05)
                xsp = sign(xsp) * 0.05;
            
            gemdir = point_direction(0, 0, xsp, ysp);
            
            if (xx > (global.plx - atr) && xx < (global.plx + atr) && yy > (global.ply - atr) && yy < (global.ply + atr))
            {
                if (suckable)
                {
                    attracted = 1;
                    gemdir = point_direction(xx, yy, global.plx, global.ply);
                    gemsp = 4;
                    rotsp = 32;
                }
            }
            
            xx += xsp;
            yy += ysp;
        }
    }
    else
    {
        image_speed = 0;
        
        for (i = 0; i <= 3; i += 1)
        {
            if (alarm[i] > 0)
                alarm[i] += 1;
        }
        
        if (!obtainable)
            obtainable = 1;
    }
}
else if (attracted)
{
    stepRate = 1;
    pldir = point_direction(xx, yy, global.plx, global.ply);
    dirdif = gemdir - pldir;
    
    if (dirdif > 180)
        dirdif -= 360;
    else if (dirdif < -180)
        dirdif += 360;
    
    if (dirdif > rotsp)
        gemdir -= rotsp;
    else if (dirdif < -rotsp)
        gemdir += rotsp;
    else
        gemdir = pldir;
    
    rotsp += 0.6;
    
    if (rotsp > 32)
        rotsp = 32;
    
    gemsp += 0.125;
    
    if (gemsp > 9)
        gemsp = 9;
    
    xsp = lengthdir_x(gemsp, gemdir);
    ysp = lengthdir_y(gemsp, gemdir);
    xx += xsp;
    yy += ysp;
}

if (dissapearing)
    dflash *= -1;

x = round(xx);
y = round(yy);
alarm[4] = stepRate;

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
