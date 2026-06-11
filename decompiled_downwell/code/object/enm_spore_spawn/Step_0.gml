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

if (shooting == 1)
{
    if (image_index > 2)
    {
        mySpore1 = instance_create(x, y - 8, Spore);
        mySpore2 = instance_create(x, y - 8, Spore);
        
        if (cola == 1)
        {
            mySpore1.sporeDir = 70;
            mySpore2.sporeDir = 110;
            cola *= -1;
            alarm[1] = emitTimer - 60 - 15;
        }
        else
        {
            mySpore1.sporeDir = 45;
            mySpore2.sporeDir = 135;
            cola *= -1;
            alarm[1] = emitTimer;
        }
        
        shooting = 2;
    }
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
