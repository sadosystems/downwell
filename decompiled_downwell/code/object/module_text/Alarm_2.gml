if (txtExit < txtLength)
{
    txtAt[txtShown][1] = 1;
    txtExit += 1;
    alarm[2] = txtExInterval;
}
else
{
    instance_destroy();
}
