waterSprite = 734;

if (global.hardMode)
    waterSprite = 735;

repeat (20)
    instance_create(240 + random_range(-64, 64), y - random(320), airBubbleMicro);
