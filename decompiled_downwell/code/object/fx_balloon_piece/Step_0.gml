xx += xsp;
yy += ysp;
x = round(xx);
y = round(yy);
xsp *= 0.85;
ysp *= 0.85;
dir = point_direction(xx, yy, xx + xsp, yy + ysp);
image_angle = dir;
