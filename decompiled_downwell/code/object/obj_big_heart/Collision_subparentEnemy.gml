repeat (3)
    instance_create(x, y, bulletExplosion1);

repeat (3)
    instance_create(x, y, explosionSmall);

instance_destroy();
global.ballooning = 0;
instance_destroy();
