if (!allSet)
{
    if (elderBro)
    {
        brother = instance_create(x + 1, y, enmTwinbot);
        brother.elderBro = -1;
        brother.brother = id;
        broDistance = point_distance(x, y, brother.x, brother.y);
    }
    
    allSet = 1;
}

if (elderBro && broAlive)
{
    if (collision_line(x, y, brother.x, brother.y, objPlayer_n, 0, 0))
        scrTypicalDamage(1, 3, 2);
}

if (broAlive)
{
    broDistance = point_distance(x, y, brother.x, brother.y);
    broDir = point_direction(x, y, brother.x, brother.y);
}
else if (!broAlive)
{
    if (elderBro != 0)
        elderBro = 0;
}

if (TimeStopBound())
{
    pldir = point_direction(xx, yy, global.plx + (48 * elderBro), global.ply);
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
    
    if (broAlive)
    {
        if (broDistance > 48)
            enmdir = broDir;
    }
    
    xsp = lengthdir_x(enmsp, enmdir);
    ysp = lengthdir_y(enmsp, enmdir);
    scrCheckCollisionWith(57);
    
    if (xcollision != 0)
        xsp = 0;
    
    if (ycollision != 0)
        ysp = 0;
    
    xx += xsp;
    yy += ysp;
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
    
    if (broAlive)
    {
        brother.broAlive = 0;
        brother.enmdir = point_direction(x, y, brother.x, brother.y);
        brother.enmsp = 2;
        brother.maxsp = 1.5;
    }
    
    instance_destroy();
}
