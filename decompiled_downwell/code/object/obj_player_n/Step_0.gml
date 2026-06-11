if (global.pFired == 2)
    global.pFired = 0;

if (global.pFired == 1)
    global.pFired = 2;

scrAimControl();

if (global.playerSprite != sprite_index)
    global.playerSprite = sprite_index;

if (global.playerImageSpeed != image_speed)
    global.playerImageSpeed = image_speed;

if (global.playerImageIndex != image_index)
    global.playerImageIndex = image_index;

if (global.playerDamaged)
    dFlash *= -1;
else
    dFlash = -1;

global.falldepth = yy - objDepthMeter.y;
