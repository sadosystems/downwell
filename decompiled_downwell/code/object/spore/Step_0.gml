if (!allSet)
{
    xsp = lengthdir_x(sporeSpeed, sporeDir);
    ysp = lengthdir_y(sporeSpeed, sporeDir);
    allSet = 1;
}

ysp += ugrav;
xx += xsp;
yy += ysp;
x = round(xx);
y = round(yy);
