if (!damageEnd)
{
    if (object_get_parent(other.object_index) == 84)
    {
        hitIgnoreCheck(other.id);
        
        if (!hitIgnore)
        {
            if (other.wallHp > 0)
                other.wallHp -= bdmg;
        }
    }
}
