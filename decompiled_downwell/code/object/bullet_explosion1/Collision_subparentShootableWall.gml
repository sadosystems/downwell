if (damageStart && !damageEnd)
{
    hitIgnoreCheck(other.id);
    
    if (!hitIgnore)
    {
        if (other.wallHp > 0)
            other.wallHp -= bdmg;
    }
}
