event_inherited();
active = 0;
grounded = 1;
landed = 1;
image_speed = 0.2;
timerMax = 60;
timerMin = 5;
alarm[0] = 10;
timefieldImmune = 1;
nsp = 1.5;
xsp = 0;
ysp = 0;
ugrav = 0.2;
jumpsp = 4.5;
ehp = 600;
money = 50;
inWater = 0;
takenImpact = 0;
attacking = 0;
spRun = 491;
spAttack = 492;

if (grounded && !place_meeting(x + xsp, y - jumpsp, sParentSolid))
{
    attacking = 0;
    rndm = random_range(1, 1);
    ysp -= 4;
    
    if (x > global.plx)
        xsp = -nsp / 4;
    else
        xsp = nsp / 4;
    
    image_xscale = sign(xsp);
}
