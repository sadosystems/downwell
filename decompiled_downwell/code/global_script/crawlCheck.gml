function crawlCheck(arg0, arg1, arg2)
{
    posx = arg0;
    posy = arg1;
    bcx = lengthdir_x(1, direction - 90);
    bcy = lengthdir_y(1, direction - 90);
    boxSize = arg2 / 2;
    
    if (collision_rectangle((posx - boxSize) + bcx, (posy - boxSize) + bcy, posx + boxSize + bcx, posy + boxSize + bcy, parentWall, 0, 0))
        return 1;
    else
        return 0;
}
