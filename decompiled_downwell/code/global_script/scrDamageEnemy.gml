function scrDamageEnemy(arg0)
{
    other.ehp -= arg0;
    other.damageStun = 1;
    momentDelay();
}
