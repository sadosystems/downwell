if (active)
{
    if (!global.pTimeStop)
        scrTypicalDamage(1, 3, 2);
    
    scrFxNol(85, 0.3);
    instance_destroy();
}
