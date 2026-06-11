if (!global.death)
{
    if (!active)
    {
        alarm[0] = 5;
        objPlayer_n.goalStop = 1;
        global.noControl = 1;
        active = 1;
    }
}
