if (flashing)
    dFlash *= -1;

ysp += ugrav;
scrCheckCollisionWith(57);

if (xcollision != 0)
    xsp *= -xcollision;

if (ycollision != 0)
    ysp *= -ycollision;

xx += xsp;
yy += ysp;
xsp *= 0.99;
ysp *= 0.99;
roundPosition();
