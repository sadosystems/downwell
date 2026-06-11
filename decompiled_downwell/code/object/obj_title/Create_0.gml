image_speed = 0;
bong = 0;

if (global.initTimes >= 2)
{
    bong = 1;
    global.firstBoot = 1;
    image_index = image_number - 1;
    alarm[1] = 10;
}
