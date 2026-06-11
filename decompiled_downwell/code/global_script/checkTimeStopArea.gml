function checkTimeStopArea()
{
    if (place_meeting(x, y, parentTimeField))
        return 1;
    else if (x < 160)
        return 1;
    else if (x > (room_width - 160))
        return 1;
    else
        return 0;
}
