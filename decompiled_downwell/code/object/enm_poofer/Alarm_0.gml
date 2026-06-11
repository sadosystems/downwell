for (i = 0; i <= 3; i += 1)
{
    myPoof = instance_create(xx, yy, enmBulRanged);
    
    if (pooferTypeD)
        myPoof.ebDir = 45 + (90 * i);
    else
        myPoof.ebDir = 90 * i;
    
    myPoof.sprite_index = sprEnmbulCircular;
}

alarm[0] = emitTimer;
