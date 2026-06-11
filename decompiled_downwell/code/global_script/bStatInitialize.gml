function bStatInitialize()
{
    global.pBulName = "DEFAULT";
    global.pBulGunSprite = 459;
    global.pBulObject = 261;
    global.pBulSprite = 458;
    global.pBulSound = 18;
    global.pBulMuzzle = 603;
    global.pBulConRate = 2;
    global.pBulRof = 4;
    global.pBulRecoil = 0.3;
    global.pBulScreenShake = -8;
    global.pBulScreenShakeDur = 5;
    global.pBulDelayKill = 1;
    global.pBulBurst = 0;
    global.pBulBurstRate = 0;
    global.pBulBurstAmount = 0;
    global.pBulDamage = 10;
    global.pBulSpeed = 8;
    global.pBulAccuracy = 0;
    global.pBulPierce = 0;
    global.pBulWave = 0;
    global.pBulExplode = 0;
    global.pBulSpecial[0] = 0;
    global.pBulSpecial[1] = 0;
    global.pBulSpType = 0;
    global.pBulSp1 = 0;
    global.pBulSp2 = 0;
    global.pBulSp3 = 0;
    global.aimAngleAccl = 5;
    global.aimAngleDccl = 2;
    global.aimAngleLimit = 30;
    global.prvRandBulType = 0;
    global.prvRandBulSubType = 0;
    bStatInitLevel1();
    global.pGunType = 0;
    bStatUpdate(global.pGunType, global.pGunLevel);
}
