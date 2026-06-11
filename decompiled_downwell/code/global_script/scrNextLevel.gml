function scrNextLevel(arg0)
{
    global.level += 1;
    
    if (global.area == 0)
        global.area = 1;
    
    if (global.level > 3)
    {
        global.area += 1;
        global.level = 1;
    }
    
    if (arg0 > 0)
    {
        global.area = arg0;
        global.level = 1;
    }
    
    if (global.area >= 5)
        room_goto(rmMain);
    else
        room_goto(rmMain);
    
    global.wallTile = global.levelTile[global.area];
}
