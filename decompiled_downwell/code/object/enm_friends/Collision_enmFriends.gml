for (i = 0; i <= 1; i += 1)
{
    if (i == 0)
    {
        if (other.id == brother[1])
            noGo = 1;
        else
            noGo = 0;
    }
    
    if (i == 1)
    {
        if (other.id == brother[0])
            noGo = 1;
        else
            noGo = 0;
    }
    
    if (!noGo)
    {
        if (!broAlive[i])
        {
            if (!other.broAlive[i])
            {
                broAlive[i] = 1;
                brother[i] = other.id;
                elderBro[i] = 1;
                other.elderBro[i] = -1;
                other.brother[i] = id;
                other.broAlive[i] = 1;
            }
        }
    }
}

if ((x + y) == (other.x + other.y))
    enmdir = irandom(359);
else
    enmdir = point_direction(other.x, other.y, x, y);

enmsp = 2;
