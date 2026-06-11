ysp += ugrav;
xx += xsp;
yy += ysp;
x = round(xx);
y = round(yy);

if (image_index > (image_number - 1))
{
    image_speed = 0;
    depth = 20000;
    dFlash *= -1;
    alarm[0] = 60;
}

image_angle += angleAdd;
