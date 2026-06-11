if (deathani == -1)
{
    deathani = -2;
    instance_create(0, 0, DeathMenu);
}
else if (deathani)
{
    deathani = -1;
    
    if (grounded)
        instance_create(x, y, objJumpSmallerFx);
    
    alarm[0] = 120;
}
