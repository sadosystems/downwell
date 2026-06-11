function alarmStop(arg0)
{
    if (!TimeStopBound())
    {
        for (i = 0; i <= arg0; i += 1)
        {
            if (alarm[i] > 0)
                alarm[i] += 1;
        }
    }
}
