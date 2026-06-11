if (charging)
{
    charging = 0;
    myPoof = instance_create(xx - (8 * sign(xsp)), yy, pooferBullet);
    myPoof.ebDir = 90;
    enmdir = 270;
    enmsp = 2;
}

alarm[1] = 60;
