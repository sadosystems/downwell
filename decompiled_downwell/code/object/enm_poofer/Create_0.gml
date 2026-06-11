event_inherited();
bulletImmune = 0;
bulletThrough = 0;
ehp = 60;
xsp = 0;
ysp = 0;
vel = random_range(1, 1.5);
pooferTypeD = 1;

if (pooferTypeD)
    sprite_index = sprPooferD;
else
    sprite_index = sprPooferS;

xx = x;
yy = y;
hitStun = 0;
emitTimer = 60;
alarm[0] = emitTimer;
movesp = 0.2;
maxsp = 0.2;
acclamt = 0.05;
dcclamt = 0.001;
moyacone = 10;
rotatesp = 3;
ang16 = 22.5;
direction = point_direction(x, y, global.plx, global.ply);
playerDir = direction;
money = 4;
active = 1;
imgSp = 0.2;
image_speed = imgSp;
