event_inherited();
objHp = 1;
hitStun = 0;
hitEffect = 1;
stomped = 0;
active = 1;
image_index = 0;
image_speed = 0;
image_xscale = choose(1, -1);
sprite_index = sprScattered;
mask_index = sprite_index;
scatterType = irandom(image_number - 2);

if (random(300) < 1)
    scatterType = image_number - 1;

image_index = scatterType;
image_speed = 0;
