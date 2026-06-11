camera_set_view_size(view_camera[0], 160, global.g_cameraHeight);
global.bgm = 193;
audio_sound_gain(global.bgm, 1, 0);
soundPlayOL(global.bgm, 100, 1, 1, "music");
instance_create(0, 0, ditherFade);
global.noControl = 1;
