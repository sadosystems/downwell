function scrPlayerEmitBullet(arg0, arg1, arg2)
{
    emitx = arg0 + shootLeg;
    emity = arg1;
    emitdir = arg2;
    shootLeg *= -1;
    scrEffectSpawn(emitx, y + 12, global.pBulMuzzle, 0.5, emitdir, -60000);
    myBullet = instance_create(emitx, emity, global.pBulObject);
    myBullet.bDir = emitdir;
    
    if (global.pBulSpType == 1)
    {
        for (i = 1; i <= global.pBulSp1; i += 1)
        {
            myBullet = instance_create(emitx, emity, global.pBulObject);
            myBullet.bDir = emitdir + (global.pBulSp2 * i);
            myBullet = instance_create(emitx, emity, global.pBulObject);
            myBullet.bDir = emitdir - (global.pBulSp2 * i);
        }
    }
    else if (global.pBulSpType == 2)
    {
        for (i = 1; i <= global.pBulSp1; i += 1)
        {
            myBullet = instance_create(emitx + (global.pBulSp2 * i), emity - 2, global.pBulObject);
            myBullet.bDir = emitdir;
            myBullet = instance_create(emitx - (global.pBulSp2 * i), emity - 2, global.pBulObject);
            myBullet.bDir = emitdir;
        }
    }
}
