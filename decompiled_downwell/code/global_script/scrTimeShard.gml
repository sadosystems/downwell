function scrTimeShard()
{
    if (instance_place(x, y, parentTimeField))
    {
        myTimeField = instance_place(x, y, parentTimeField);
        tf2p = point_direction(myTimeField.x, myTimeField.y, x, y);
    }
    else
    {
        tf2p = point_direction(0, 0, xsp, ysp);
    }
    
    repeat (2)
    {
        tf2pf = tf2p + random_range(-45, 45);
        shardSp = random_range(1, 6);
        myTimeShard = instance_create(x, y, fxTimeShard);
        myTimeShard.xsp = lengthdir_x(shardSp, tf2pf);
        myTimeShard.ysp = lengthdir_y(shardSp, tf2pf);
    }
    
    tf2p += 180;
    
    repeat (1)
    {
        tf2pf = tf2p + random_range(-45, 45);
        shardSp = random_range(1, 6);
        myTimeShard = instance_create(x, y, fxTimeShard);
        myTimeShard.xsp = lengthdir_x(shardSp, tf2pf);
        myTimeShard.ysp = lengthdir_y(shardSp, tf2pf);
    }
}
