function TimeStopBound()
{
    if (!(global.pTimeStop && !checkTimeStopArea()))
        return 1;
    else
        return 0;
}
