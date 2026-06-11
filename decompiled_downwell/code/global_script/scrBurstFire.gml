function scrBurstFire()
{
    muzzlex = x;
    muzzley = y + 4;
    scrPlayerEmitBullet(muzzlex, muzzley, shotAngle);
    scrSShake(global.pBulScreenShake, global.pBulScreenShakeDur);
    scrShotSound();
    ysp = global.pBulRecoil;
    global.pFired = 1;
    instance_create(x, y, bulletCasing);
    image_index = 0;
    
    if (burstCount < global.pBulBurstAmount)
    {
        alarm[3] = global.pBulBurstRate;
        burstCount += 1;
    }
    else
    {
        burstCount = 0;
    }
}
