memorizey = 0;
camSlowdown = 5;
camSlowdownX = 1;
daop = 3;
camPointy = objPlayer_n.y;
camPointx = 80;
camAccly = ((camPointy + (16 * daop)) - y) / 5;
camAcclx = (80 - x) / 10;
chasePlayer = 1;

if (groundRoom())
{
    freeCam = 1;
    y = 464;
    camSlowdownX = 10;
    x = objPlayer_n.x;
}
else
{
    freeCam = 0;
}

xx = x;
yy = y;
