event_inherited();
ehp = 10;
active = 0;
grounded = 0;
jumpySound = choose(137, 138, 139, 140, 141);
normalSpr = 242;
stunSpr = 245;
deadSpr = 246;
mask_index = sprJumpySkull;
xsp = 0.5;
ysp = 0;
ugrav = 0.15;
jumpsp = -2.2;

if (global.area == 3)
{
    ugrav = 0.06818181818181818;
    jumpsp = -1.5;
}

leapState = 0;
xx = x;
yy = y;
money = 4;
imgSp = 0.175;
image_speed = imgSp;
leapTimer = 30;
alarm[1] = leapTimer;
