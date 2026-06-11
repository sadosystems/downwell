material = "breakable";
sprite_index = global.wallTile;
autoTile = 0;
checked = 0;
breakSound = 171;

switch (global.area)
{
    case 1:
        breakSound = choose(171, 172, 173, 174);
        break;
    
    case 2:
        breakSound = choose(175, 176, 177, 178);
        break;
    
    case 3:
        breakSound = choose(171, 172, 173, 174);
        break;
    
    case 4:
        breakSound = choose(179, 180, 181, 182);
        break;
}

if (global.glitchMode)
    sprite_index = choose(sprTile1, sprTile2, sprTile3, sprTile4, sprTileGrowth);

image_speed = 0;
image_index = choose(16, 17);
wallHp = 1;
drilled = 0;
haveGem = irandom(50) < 1;

if (global.area == 3)
    haveGem = 0;

if (groundRoom())
    haveGem = 0;

if (haveGem == 1)
{
    image_index = choose(18, 19);
    haveGem = 2;
}

if (haveGem == 2)
    image_index = 22;
