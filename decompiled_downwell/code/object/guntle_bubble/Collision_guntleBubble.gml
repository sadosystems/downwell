if (x != other.x)
    xx += lengthdir_x(1, point_direction(other.x, other.y, x, y));
else
    xx += lengthdir_x(irandom_range(-1, 1), point_direction(other.x, other.y, x, y));
