if (!broAlive)
{
    if (!other.broAlive)
    {
        broAlive = 1;
        brother = other.id;
        elderBro = 1;
        brother.elderBro = -1;
        brother.brother = id;
        brother.broAlive = 1;
        broDistance = point_distance(x, y, brother.x, brother.y);
        broDir = point_direction(x, y, brother.x, brother.y);
        
        with (brother)
        {
            broDistance = point_distance(x, y, brother.x, brother.y);
            broDir = point_direction(x, y, brother.x, brother.y);
        }
    }
}

if ((x + y) == (other.x + other.y))
    enmdir = irandom(359);
else
    enmdir = point_direction(other.x, other.y, x, y);
