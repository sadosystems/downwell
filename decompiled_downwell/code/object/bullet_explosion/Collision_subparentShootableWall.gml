if (damageStart && !damageEnd)
{
    hitIgnoreCheck(other);
    
    if (!hitIgnore)
    {
        if (other.wallHp > 0)
            other.wallHp -= bdmg;
    }
}
