sprite_index = global.wallTile;

if (global.glitchMode)
    sprite_index = choose(sprTile1, sprTile2, sprTile3, sprTile4, sprTileGrowth);

material = "foliage";
image_speed = 0;
deactivate = 0;
checked = 0;
checkwall = 0;
i = 0;
grass = -1;
surrounded = 0;
lightCheck = 0;
isPillar = 0;
lightUpLeft = 0;
lightUpRight = 0;
lightDownLeft = 0;
lightDownRight = 0;
