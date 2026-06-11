if (global.debugMode)
{
    global.noBgm *= -1;
    
    if (global.noBgm == 1)
        audio_stop_sound(global.OLchannel[5]);
    else
        audio_play_sound(global.OLchannel[5], 100, 1);
    
    ini_open("save.ini");
    ini_write_real("stats", "nobgm", global.noBgm);
    ini_close();
}
