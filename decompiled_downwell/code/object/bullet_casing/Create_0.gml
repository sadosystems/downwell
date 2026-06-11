event_inherited();
bdmg = 0;
bSpeed = 5;
allSet = 1;
xsp = random_range(-3, -1) * sign(objPlayer_n.image_xscale);
ysp = random_range(-3, 0);
image_speed = choose(-0.5, -0.3, 0, 0.3, 0.5);
alarm[0] = 15;

if (global.pugLeak)
{
    bdmg = 5;
    alarm[0] = 30 * global.pugLeak;
    sprite_index = sprLeakBullet;
}

dFlash = 1;
flashing = 0;
ugrav = 0.08;
ugravhard = 0.2;
