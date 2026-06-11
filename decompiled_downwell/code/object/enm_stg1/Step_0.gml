if (!global.pTimeStop)
{
    if (hit)
    {
        hit = 0;
        image_index = 0;
        hitStun = 1;
        alarm[0] = 5;
    }
    
    if (!active)
    {
        if (global.ply > (targety - 128))
            active = 1;
    }
    
    if (active)
    {
        if (!targetReached)
        {
            yy += ((targety - yy) / 20);
            
            if (yy < (targety + 3))
            {
                targetReached = 1;
                alarm[1] = 1;
            }
        }
        else if (shot)
        {
            ysp -= 0.05;
        }
    }
    
    if (hitStun)
        sprite_index = stunSpr;
    else
        sprite_index = normalSpr;
    
    xx += xsp;
    yy += ysp;
    roundPosition();
}
else
{
    alarmStop(0);
}

if (ehp <= 0)
    alive = 0;

if (!alive)
{
    scrEnemyDeath();
    scrBloodfx(0, 0);
    scrSmokefx(xx, yy, 1, 0);
    scrFlashballfx(xx, yy, 1, 0, 0);
    scrCurrencySpawn(money);
    scrDeadBody(deadSpr, takenImpact, 102);
    instance_destroy();
}
