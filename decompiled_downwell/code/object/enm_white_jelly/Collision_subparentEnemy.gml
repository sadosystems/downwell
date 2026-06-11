if ((x + y) == (other.x + other.y))
    direction = irandom(359);
else
    direction = point_direction(other.x, other.y, x, y);
