function soundPlayOL(arg0, arg1, arg2, arg3, arg4)
{
    sfxIndex = arg0;
    soundPriority = arg1;
    loop = arg2;
    cutPrv = arg3;
    OLnum = arg4;
    chanNum = 0;
    
    switch (OLnum)
    {
        case "footsteps":
            chanNum = 0;
            break;
        
        case "gunshot":
            bgmDuck(200, global.pBulSp3);
            chanNum = 1;
            break;
        
        case "gunwall":
            chanNum = 2;
            break;
        
        case "merchant":
            chanNum = 3;
            break;
        
        case "enemymove":
            chanNum = 4;
            break;
        
        case "music":
            chanNum = 5;
            break;
        
        case "waterEnemy":
            chanNum = 6;
            break;
        
        case "waterThings":
            chanNum = 7;
            break;
        
        case "UI":
            chanNum = 8;
            break;
        
        case "boss":
            chanNum = 9;
            break;
    }
    
    doNotPlay = 0;
    
    if (chanNum == 4 || chanNum == 6)
    {
        if (y > (__view_get(e__VW.YView, 0) + __view_get(e__VW.HView, 0)))
            doNotPlay = 1;
        else if (y < __view_get(e__VW.YView, 0))
            doNotPlay = 1;
        
        cutPrv = 0;
        
        if (audio_is_playing(sfxIndex))
            audio_stop_sound(sfxIndex);
    }
    
    if (chanNum >= 7)
    {
        cutPrv = 0;
        
        if (audio_is_playing(sfxIndex))
            audio_stop_sound(sfxIndex);
    }
    
    if (!doNotPlay)
    {
        if (cutPrv)
        {
            if (audio_is_playing(global.OLchannel[chanNum]))
                audio_stop_sound(global.OLchannel[chanNum]);
        }
        
        global.OLchannel[chanNum] = sfxIndex;
        sndsnd = audio_play_sound(sfxIndex, soundPriority, loop);
        sndgain = audio_sound_get_gain(sndsnd);
        sndgain *= global.gameVolume;
        audio_sound_gain(sndsnd, sndgain, 0);
        
        if (global.gInWater && (chanNum < 5 || chanNum >= 9))
            audio_sound_pitch(sndsnd, 0.55);
        else
            audio_sound_pitch(sndsnd, 1);
        
        if (chanNum == 5)
        {
            if (global.noBgm)
                audio_stop_sound(sfxIndex);
        }
        
        if (audio_is_playing(sndsnd))
            return sndsnd;
        else
            return -1;
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
