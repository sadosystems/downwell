if (y > global.ply)
{
    if (!objPlayer_n.grounded)
    {
        if (objPlayer_n.ysp > 0)
            scrEnemyStomped();
    }
}

if (objPlayer_n.grounded)
    scrTypicalDamage(1, 3, 2);
else if (global.ply > y)
    scrTypicalDamage(1, 3, 2);
