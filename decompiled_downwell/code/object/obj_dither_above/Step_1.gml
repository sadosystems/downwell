x = parentCamera.x;

if (!global.lowSpec)
{
    if ((parentCamera.y - y) >= 272)
        y += 16;
}
else if ((parentCamera.y - y) >= 208)
{
    y += 16;
}

y = round(y);

if (global.ending)
    instance_destroy();
