if (!meowed)
{
    meowsnd = soundPlay(choose(346, 347), 80, 0, 1);
    
    if (choose(0, 1, 1, 1))
    {
        meowed = 1;
        alarm[2] = irandom_range(180, 300);
    }
    else
    {
        alarm[2] = irandom_range(120, 180);
    }
    
    meow = 1;
    alarm[3] = 30;
}
else
{
    meowed = 0;
    alarm[0] = irandom_range(120, 240);
    walking = 1;
}
