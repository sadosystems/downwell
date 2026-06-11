roomw = room_width;
sideLocked = 0;
camFocus = 0;
camShake = 0;
camShakeAmt = 0;
endingCamera = 0;
creditSpawn = 0;
memorizey = 0;
camSlowdown = 5;
camSlowdownX = 1;
autoScroll = 0;
daop = 24;

if (groundRoom())
    daop = -32;

camPointy = objPlayer_n.y;
camPointx = objPlayer_n.x;
camAccly = ((camPointy + daop) - y) / 5;
camAcclx = (80 - x) / 10;
chasePlayer = 1;
centered = 1;
freeCam = 0;
xAhead = 16;
roomEnd = -1;
x = camPointx;
y = camPointy;
xx = x;
yy = y;
