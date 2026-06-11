function scrFireBulletN(arg0, arg1, arg2)
{
    emitx = arg0;
    emity = arg1;
    emitdir = arg2;
    scrEffectSpawn(x, y + 12, global.pBulMuzzle, 0.5, emitdir, -60000);
    myBullet = instance_create(emitx, emity, global.pBulObject);
    myBullet.bDir = emitdir;
}
