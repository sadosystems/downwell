xsp = random_range(-2, 2);
ysp = random_range(-0.5, 1);

switch (global.area)
{
    case 1:
        sprite_index = sprDebrisRock;
        break;
    
    case 2:
        sprite_index = sprDebrisWood;
        break;
    
    case 3:
        sprite_index = sprDebrisRock;
        break;
    
    case 4:
        sprite_index = sprPoisonPotPieces;
        break;
    
    case 5:
        sprite_index = sprDebrisRock;
        break;
}

ugrav = 0.08;
ugravhard = 0.1;
imgSp = choose(-0.5, -0.3, 0, 0.3, 0.5);
image_speed = imgSp;
image_index = random(7);

if (instance_number(breakablesDebris) < 5)
{
    alarm[0] = 30;
    alarm[1] = 15;
    alarm[2] = 7;
}
else
{
    alarm[0] = 30;
    alarm[1] = 15;
    alarm[2] = 7;
}

dissapearing = 0;
dflash = -1;
noTouch = 1;
