myPoof = instance_create(xx - (8 * sign(xsp)), yy, pooferBullet);

switch (sign(xsp))
{
    case 1:
        myPoof.ebDir = 180;
        break;
    
    case -1:
        myPoof.ebDir = 0;
        break;
}

alarm[1] = emitTimer;
