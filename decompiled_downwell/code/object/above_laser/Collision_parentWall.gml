if (other.object_index == objWall_n)
{
    if (other.isPillar == 0)
    {
        with (other)
        {
            repeat (2)
                instance_create(x, y - 16, breakablesDebris);
            
            instance_destroy();
        }
    }
}
else
{
    with (other)
    {
        repeat (2)
            instance_create(x, y - 16, breakablesDebris);
        
        instance_destroy();
    }
}
