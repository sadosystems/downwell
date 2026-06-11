if (txtShown < txtLength)
{
    txtAt[txtShown][1] = 1;
    txtShown += 1;
    alarm[0] = txtApInterval;
}
else
{
    alarm[1] = txtRemainTime;
}
