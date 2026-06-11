event_inherited();
objHp = 1;
image_speed = 0;
collisionOn = 1;
xsp = 0;
ysp = 0;
ugrav = 0.01;
obtainable = 0;
addAmount = 1;
unobtime = 10;
obtime = 0;
distime = 120;
alarm[0] = unobtime;
dissapearing = 0;
dflash = -1;
grounded = 0;
moduleType = choose(0, 1);

if (global.playerHp <= 2)
    moduleType = choose(0, 1, 1, 1, 1, 1, 1);

if (global.area == 5)
    moduleType = 1;

if (moduleType == 1)
    sprite_index = sprModHeart;
else
    sprite_index = sprModBtry;

while (true)
{
    moduleNum = irandom(global.bulletMaxNum);
    
    if (global.pGunType != moduleNum)
        break;
}

moduleImage = global.bStatGunSprite[moduleNum];
alarm[3] = 10;
xx = x;
yy = y;
