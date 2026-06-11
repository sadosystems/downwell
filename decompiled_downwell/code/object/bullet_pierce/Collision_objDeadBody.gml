other.xsp = 0;
other.ysp = 0;
other.bouncing = 0;

if (!place_meeting(x, y, parentThinwall))
{
    other.yy = y;
    other.xsp = xsp;
    other.ysp = ysp;
}
