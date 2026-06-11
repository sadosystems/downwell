if (!damageEnd)
{
    hitIgnoreCheck(other);
    
    if (!hitIgnore)
    {
        if (other.objHp > 0)
        {
            other.objHp -= bdmg;
            scrFlashballfx(x, y, 1, 0, 0);
        }
    }
}
