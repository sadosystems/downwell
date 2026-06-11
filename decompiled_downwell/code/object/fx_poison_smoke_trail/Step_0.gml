x += xsp;
y += ysp;
xsp *= decspeed;
ysp *= decspeed;

if (collision_point(x + xsp, y + ysp, parentWall, 0, 0))
{
    xsp *= 0.5;
    ysp *= 0.5;
}
