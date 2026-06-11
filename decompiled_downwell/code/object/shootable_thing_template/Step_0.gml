scrOutofview();

if (objHp <= 0 && active)
{
    scrBloodfx(10, 3);
    scrSmokefx(x, y, 2, 1);
    scrFlashballfx(x, y, 2, 1, 3);
    audio_play_sound(sndPlip, 0, 0);
    instance_destroy();
}
