if (!allSet)
{
    if (place_meeting(xx, yy, sParentSolid))
        instance_destroy();
    else if (place_meeting(xx, yy + 8, sParentSolid))
        placement = 0;
    else if (place_meeting(xx + 8, yy, parentWall))
        placement = 1;
    else if (place_meeting(xx - 8, yy, parentWall))
        placement = 2;
    else
        instance_destroy();
    
    if (placement != -1)
        instance_create(x, y - 8, TorchFire);
    
    image_index = placement;
    allSet = 1;
}
