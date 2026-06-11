if (x == other.x)
{
    if (id > other.id)
        xsp = 0.2;
}
else
{
    xsp = sign(x - other.x) * 0.2;
}
