function emitSquidInk(arg0, arg1, arg2, arg3)
{
    posx = arg0;
    posy = arg1;
    inkdir = arg2;
    inksp = arg3;
    myInk = instance_create(posx, posy, squidInk);
    myInk.direction = inkdir;
    myInk.movesp = inksp;
}
