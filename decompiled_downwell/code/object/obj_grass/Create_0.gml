event_inherited();
sprite_index = choose(sprGrass, sprGrass2, sprGrass3, sprGrass4);
image_speed = random_range(0.15, 0.25);
image_xscale = 1;
active = 1;
image_index = irandom(image_number - 1);

if (random(10) < 1)
    instance_destroy();
