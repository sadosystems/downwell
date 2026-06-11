if (flashing)
    dFlash *= -1;

if (ysp < -1)
    ysp += ugravhard;
else
    ysp += ugrav;

if (place_meeting(x + xsp, y, parentWall))
{
    xsp *= -1;
    xsp *= 0.7;
}

bDir = point_direction(0, 0, xsp, ysp);

if (abs(xsp) < 0.05)
    xsp = sign(xsp) * 0.05;

scrBulCheckSolid();

if (TimeStopBound())
{
    x += xsp;
    y += ysp;
}
