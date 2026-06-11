function momentDelay()
{
    if (room_speed == 60)
    {
        with (objControlerN)
        {
            room_speed = 30;
            slown = 30;
            alarm[0] = 1;
        }
    }
}
