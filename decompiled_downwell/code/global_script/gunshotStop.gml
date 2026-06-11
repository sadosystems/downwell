function gunshotStop()
{
    if (global.toggleGuncut)
    {
        if (audio_is_playing(global.OLchannel[1]))
            audio_stop_sound(global.OLchannel[1]);
    }
}
