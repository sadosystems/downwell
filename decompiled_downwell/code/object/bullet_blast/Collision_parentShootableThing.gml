if (!damageEnd)
{
    hitIgnoreCheck(other.id);
    
    if (!hitIgnore)
    {
        if (other.objHp > 0)
        {
            other.objHp -= bdmg;
            scrFlashballfx(x, y, 1, 0, 0);
        }
    }
}
