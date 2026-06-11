function speedChange(arg0, arg1)
{
    if (arg0 <= room_speed)
    {
        room_speed = arg0;
        objControlerN.alarm[0] = arg1;
    }
}
