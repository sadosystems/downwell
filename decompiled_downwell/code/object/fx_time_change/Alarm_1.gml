if (room_speed < 60)
{
    room_speed += speedInc;
    alarm[1] = alarmAlarm;
}
else
{
    room_speed = 60;
    instance_destroy();
}
