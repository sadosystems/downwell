if (image_index > damageStartFrame)
    damageStart = 1;

if (image_index > damageEndFrame)
    damageEnd = 1;

if (TimeStopBound())
{
    image_speed = imgSp;
}
else
{
    image_speed = 0;
    alarmStop(0);
}
