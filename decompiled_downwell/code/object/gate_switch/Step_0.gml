if (wallHp <= 0)
{
    emitMovingFx(x, y, 118, 0.7, 0, 0);
    target = 0;
    target = instance_place(x, y - 16, Gate);
    
    if (target)
    {
        if (!target.breaking)
            target.breaking = 3;
    }
    
    target = instance_place(x, y + 16, Gate);
    
    if (target)
    {
        if (!target.breaking)
            target.breaking = 1;
    }
    
    target = instance_place(x - 16, y, Gate);
    
    if (target)
    {
        if (!target.breaking)
            target.breaking = 2;
    }
    
    target = instance_place(x + 16, y, Gate);
    
    if (target)
    {
        if (!target.breaking)
            target.breaking = 4;
    }
    
    instance_destroy();
}
