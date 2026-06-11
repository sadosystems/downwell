event_inherited();
objHp = 30;
hitStun = 0;
hitEffect = 1;
active = 1;
image_index = 0;
image_speed = 0;
tankType = irandom(3);

switch (tankType)
{
    case 0:
        normalSprite = 539;
        hitSprite = 540;
        break;
    
    case 1:
        normalSprite = 541;
        hitSprite = 542;
        break;
    
    case 2:
        normalSprite = 543;
        hitSprite = 544;
        break;
    
    case 3:
        normalSprite = 545;
        hitSprite = 546;
        break;
}

mask_index = normalSprite;
sprite_index = normalSprite;

if (x > (room_width / 2))
    image_xscale = -1;
