if (global.hardMode)
    sprite_index = sprBubbleMicroRed;

if (objPlayer_n.ysp > 0)
{
    ysp = random_range(-objPlayer_n.ysp / 1.5, 0);
    xsp = random(2) * choose(1, -1);
}

if (objPlayer_n.ysp <= 0)
{
    ysp = random_range(-1, -2);
    xsp = random(1) * choose(1, -1);
}

alarm[0] = 120;
ugrav = 0.02;
image_speed = 0.3;
image_index = irandom(7);
