if (!allSet)
{
    bDir += random_range(-bdirRand, bdirRand);
    xsp = lengthdir_x(bSpeed, bDir);
    ysp = lengthdir_y(bSpeed, bDir);
    image_angle = bDir;
    allSet = 1;
}

image_angle = bDir;
disap *= -1;
xsp = lengthdir_x(bSpeed, bDir);
ysp = lengthdir_y(bSpeed, bDir);

if (collision_line(x, y, x + xsp, y + ysp, subparentSolidWall, 0, 0) && !collision_line(x, y, x + xsp, y + ysp, subparentEnemy, 0, 0))
{
    thatWall = collision_line(x, y, x + xsp, y + ysp, subparentSolidWall, 0, 0);
    whileStop = 0;
    
    while (!collision_point(x, y, subparentSolidWall, 0, 0))
    {
        y += (ysp / 10);
        x += (xsp / 10);
        whileStop += 1;
        
        if (whileStop > 100)
            break;
    }
    
    if (object_get_parent(thatWall.object_index) == 84)
    {
        if (thatWall.wallHp > 0)
        {
            thatWall.wallHp -= bdmg;
            
            if (!bConsistent)
                instance_destroy();
        }
    }
    else if (object_get_parent(thatWall.object_index) == 59)
    {
        xsp = 0;
        ysp = 0;
        
        if (!stuck)
        {
            stuck = 1;
            mask_index = noMask;
            bdmg = 0;
            alarm[0] = 30;
        }
    }
}
else if (place_meeting(x, y, parentShootableThing))
{
    thatThing = instance_place(x, y, parentShootableThing);
    
    if (thatThing.objHp > 0)
    {
        thatThing.objHp -= bdmg;
        scrFlashballfx(x, y, 1, 0, 0);
        
        if (!bConsistent)
            instance_destroy();
    }
}

x += xsp;
y += ysp;
