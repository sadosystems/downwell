myExplosion = instance_create(x, y, fxJobutsu);
myExplosion.sprite_index = explosionFx;

for (i = 0; i <= 3; i += 1)
{
    myBul = instance_create(x, y, enmbul1);
    myBul.sprite_index = sprUneedle;
    myBul.ebDir = 90 * i;
    myBul.imageAngled = 1;
    myBul.ebSpeed = 1;
}

instance_destroy();
