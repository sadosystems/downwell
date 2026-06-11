myBullet = instance_create(x, y, bulletDrone);
myBullet.bDir = 270 + angRand;
myBullet.bSpeed = 16;
myBullet.bdmg = 5;
myBullet.sprite_index = sprBulLaser;

if (emitted < emitAmt)
    alarm[0] = emitTimer;
else
    instance_destroy();

emitted += 1;
