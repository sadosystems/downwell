if (abs(xsp) > 0.025)
    xsp *= 0.95;
else
    xsp = 0;

if (!scrInView(0, 0, 0))
    xsp = 0;

if (scrInView(0, 0, 0))
    ysp -= 0.01;

xx += xsp;
yy += ysp;
x = round(xx);
y = round(yy);

if (ehp <= 0)
    instance_destroy();
