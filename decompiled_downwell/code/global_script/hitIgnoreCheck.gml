function hitIgnoreCheck(arg0)
{
    checkTarget = arg0;
    checkTarget = other.id;
    hitIgnore = 0;
    
    if (hitMemCount > 0)
    {
        for (i = 0; i < hitMemCount; i += 1)
        {
            if (hitMem[i] == checkTarget)
                hitIgnore = 1;
        }
        
        if (!hitIgnore)
        {
            hitMem[hitMemCount] = checkTarget;
            hitMemCount += 1;
        }
    }
    else
    {
        hitMem[hitMemCount] = checkTarget;
        hitMemCount += 1;
    }
}
