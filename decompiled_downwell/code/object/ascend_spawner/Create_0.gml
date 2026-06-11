y += 320;
emitAmt = irandom_range(4, 7);
emitted = 0;
emitRate = 20;
alarm[0] = emitRate;
xsp = random(0.5);

if (x > (room_width / 2))
    xsp *= -1;
