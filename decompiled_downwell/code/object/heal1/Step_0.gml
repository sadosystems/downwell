ysp = 0.5;

if (!global.pTimeStop)
{
    xx += ((global.plx - xx) / 10);
    yy += ((global.ply - yy) / 10);
}

roundPosition();
