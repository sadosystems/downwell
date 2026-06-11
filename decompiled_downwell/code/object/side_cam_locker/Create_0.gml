roomw = room_width;

if (x < 160)
{
    placement = -1;
    x = 80;
}
else if (x > (roomw - 160))
{
    placement = 1;
    x = roomw - 80;
}
