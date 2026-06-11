if (txtShown < txtLength)
{
    txtAt[txtShown][1] = 1;
    txtShown += 1;
    alarm[0] = txtApInterval;
    soundPlay(334, 80, 0, 1);
}
else
{
    alarm[1] = txtRemainTime;
}
