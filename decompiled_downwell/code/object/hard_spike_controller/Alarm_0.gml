if (!global.hardSpikeActivate)
{
    global.hardSpikeActivate = 1;
    alarm[0] = 1;
}
else if (global.hardSpikeActivate)
{
    global.hardSpikeActivate = 0;
    alarm[0] = hardSpikeInterval;
}
