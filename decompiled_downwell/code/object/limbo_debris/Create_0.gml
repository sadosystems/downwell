xx = x;
yy = y;
image_speed = 0;
sprite_index = sprDebrisSmall;

if (random(20) < 1)
{
    sprite_index = sprDebrisBig;
    
    if (random(10) < 1)
        sprite_index = sprDebrisSmallRare;
}

image_index = irandom(image_number - 1);
image_index = irandom(image_number - 1);
image_xscale = choose(-1, 1);
floaty = 1;
floatyCircle = irandom(359);
floatySpeed = random_range(1, 2);
floatyRange = 3;
