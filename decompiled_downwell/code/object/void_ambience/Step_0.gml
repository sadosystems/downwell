if (global.pTimeStop)
{
    if (!global.death)
    {
        if (!voidAmb)
        {
            if (point_distance(x, y, global.plx, global.ply) < 160)
                voidAmb = 1;
        }
        
        if (voidAmb)
        {
            if (scrInView(0, 0, 0))
                audio_sound_gain(amb, 1, 100);
            else
                audio_sound_gain(amb, 0.3, 100);
        }
        
        if (tomato)
        {
            if (audio_is_paused(amb))
                audio_resume_sound(amb);
            
            if (global.noBgm)
                audio_sound_gain(amb, 0, 100);
        }
    }
}
else if (voidAmb)
{
    audio_sound_gain(amb, 0, 0);
    voidAmb = 0;
}
