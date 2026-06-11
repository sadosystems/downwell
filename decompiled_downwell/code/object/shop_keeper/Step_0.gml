if (!goodbye && !thankful && !confused)
{
    if (global.plx < x)
    {
        sprite_index = sprShopKeeper;
        image_speed = 0.09;
    }
    else
    {
        if (sprite_index != sprShopKeeperAngry)
        {
            sprite_index = sprShopKeeperAngry;
            image_index = 0;
            alarm[0] = irandom_range(20, 60);
        }
        
        image_speed = 0;
    }
    
    if (global.criminal)
    {
        if (global.plx > 170)
        {
            instance_destroy();
            instance_create(x, y, shopKeeperEnemy);
        }
    }
}
else if (thankful == 1)
{
    alarm[2] = 0;
    image_speed = 0.4;
    sprite_index = sprShopKeeperYay;
    
    if (image_index > 4)
    {
        image_speed = 0;
        alarm[2] = 60;
        thankful = 2;
    }
    
    confused = 0;
}
else if (goodbye == 1)
{
    image_speed = 0.2;
    sprite_index = sprShopKeeperBye;
    alarm[2] = 240;
    thankful = 0;
    confused = 0;
    goodbye = 2;
}
else if (confused == 1)
{
    image_speed = 0.2;
    sprite_index = sprShopKeeperHuh;
    
    if (image_index > 1)
    {
        image_speed = 0;
        alarm[2] = 60;
        confused = 2;
    }
    
    thankful = 0;
}

if (goodbye)
    image_speed = 0.2;

if (global.plx > x)
{
    thankful = 0;
    confused = 0;
    goodbye = 0;
}

if (global.area == 3)
    image_speed /= 2;
