if (!other.walking)
{
    if (!walking)
        walking = 1;
}
else if (x == other.x)
{
    if (id > other.id)
        walking = -1;
}
