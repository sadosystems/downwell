scrEffectSpawn(x, y + 12, 603, 0.5, 270, -60000);
myBullet = instance_create(x, y + 8, bulletDrone);
myBullet.bDir = 270;
soundPlay(47, 60, 0, 1);
droneShooting = 0;
