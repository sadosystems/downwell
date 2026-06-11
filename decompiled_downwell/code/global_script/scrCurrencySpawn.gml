function scrCurrencySpawn(arg0)
{
    moniAmount = arg0;
    atrState = 0;
    
    if (object_get_parent(object_index) == 83)
    {
        if (stomped == 1)
            atrState = 1;
    }
    
    while (moniAmount >= 10)
    {
        myGem = instance_create(x, y, objCurrency);
        
        with (myGem)
        {
            getAmount = 10;
            size = 1;
        }
        
        if (atrState)
            myGem.attracted = 1;
        
        moniAmount -= 10;
    }
    
    while (moniAmount > 0)
    {
        myGem = instance_create(x, y, objCurrency);
        
        with (myGem)
            getAmount = 2;
        
        if (atrState)
            myGem.attracted = 1;
        
        moniAmount -= 2;
    }
}
