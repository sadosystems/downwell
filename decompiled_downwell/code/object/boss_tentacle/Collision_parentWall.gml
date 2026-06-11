if (other.object_index == objWall_n)
{
    if (other.isPillar == 0)
    {
        with (other)
        {
            repeat (2)
                instance_create(x, y - 16, breakablesDebris);
            
            if (scrInView(0, 0, 0))
            {
                scrSShake(4, 3);
                breakSound = choose(171, 172, 173, 174);
                soundPlay(breakSound, 50, 0, 1);
            }
            
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
        
        if (scrInView(0, 0, 0))
            scrSShake(4, 3);
        
        instance_destroy();
    }
}
