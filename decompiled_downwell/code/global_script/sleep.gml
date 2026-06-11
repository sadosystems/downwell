function sleep(arg0)
{
    var endTime = get_timer() + (arg0 * 1000);
    
    do
    {
    }
    until (get_timer() >= endTime);
}
