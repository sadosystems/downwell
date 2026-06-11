ysp += global.grav;

if (collision_rectangle(x, y - 16, x + (160 * facing), y + 8, objPlayer_n, 0, 0))
{
    if (grounded && !leapt)
    {
        ysp = leapspy;
        xsp = leapspx * facing;
        leapt = 1;
    }
}

scrCheckCollisionWith(87);

if (ycollision != 0)
{
    if (ycollision == 1)
    {
        if (!place_meeting(xx, yy, parentThinwall))
        {
            grounded = 1;
            ysp = 0;
        }
    }
}

scrCheckCollisionWith(57);

if (xcollision != 0)
    xsp *= -0.3;

if (ycollision != 0)
{
    ysp = 0;
    
    if (ycollision == 1)
        grounded = 1;
}

if (place_meeting(xx, yy + 1, sParentSolid))
{
    if (ysp > 0)
        grounded = 1;
}
else
{
    grounded = 0;
}

if (!grounded)
    xx += xsp;

if (grounded)
{
    if (leapt == 1)
    {
        leapt = 2;
        alarm[1] = 25;
    }
}

yy += ysp;
x = round(xx);
y = round(yy);

if (hit)
{
    hit = 0;
    image_index = 0;
    hitStun = 1;
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
    instance_destroy();
}
