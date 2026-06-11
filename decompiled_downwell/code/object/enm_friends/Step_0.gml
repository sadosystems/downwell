if (!allSet)
{
    if (leader)
    {
        repeat (choose(1, 2))
        {
            sibling = instance_create(x + 1, y, enmFriends);
            sibling.leader = 0;
        }
    }
    
    allSet = 1;
}

for (i = 0; i <= 1; i += 1)
{
    if (elderBro[i] && broAlive[i])
    {
        if (collision_line(x, y, brother[i].x, brother[i].y, objPlayer_n, 0, 0))
            scrTypicalDamage(1, 3, 2);
    }
    
    if (broAlive[i])
    {
        broDistance[i] = point_distance(x, y, brother[i].x, brother[i].y);
        broDir[i] = point_direction(x, y, brother[i].x, brother[i].y);
    }
    else if (!broAlive[i])
    {
        if (elderBro[i] != 0)
            elderBro[i] = 0;
    }
}

if (TimeStopBound())
{
    pldir = point_direction(xx, yy, global.plx, global.ply);
    dirdif = enmdir - pldir;
    
    if (dirdif > 180)
        dirdif -= 360;
    else if (dirdif < -180)
        dirdif += 360;
    
    if (abs(dirdif) < viewcone)
    {
        if (enmsp < maxsp)
            enmsp += accl;
        else
            enmsp = maxsp;
    }
    else if (enmsp > 0.25)
    {
        enmsp -= dccl;
    }
    else
    {
        enmsp = 0.25;
    }
    
    if (dirdif > rotsp)
        enmdir -= rotsp;
    else if (dirdif < -rotsp)
        enmdir += rotsp;
    else
        enmdir = pldir;
    
    for (i = 0; i <= 1; i += 1)
    {
        if (broAlive[i])
        {
            if (broDistance[i] > 64)
                enmdir = broDir[i];
        }
    }
    
    xsp = lengthdir_x(enmsp, enmdir);
    ysp = lengthdir_y(enmsp, enmdir);
    scrCheckCollisionWith(57);
    
    if (xcollision != 0)
        xsp = 0;
    
    if (ycollision != 0)
        ysp = 0;
    
    if (!leader)
    {
        xx += xsp;
        yy += ysp;
    }
    
    x = round(xx);
    y = round(yy);
}

if (hit)
{
    hit = 0;
    image_index = 0;
    hitStun = 1;
    enmdir = hitDir;
    enmsp = 2;
    alarm[0] = 5;
}

if (hitStun)
    sprite_index = stunSpr;
else
    sprite_index = normalSpr;

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
    
    for (i = 0; i <= 1; i += 1)
    {
        if (broAlive[i])
        {
            brother[i].broAlive[i] = 0;
            brother[i].enmdir = point_direction(x, y, brother[i].x, brother[i].y);
            brother[i].enmsp = 2;
            brother[i].maxsp = 1.5;
        }
    }
    
    instance_destroy();
}
