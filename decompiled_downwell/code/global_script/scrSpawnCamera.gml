function scrSpawnCamera()
{
    myCam = instance_create(x, y, camMain);
    
    if (groundRoom())
        myCam.freeCam = 1;
    else if (room == rmDebug)
        myCam.freeCam = 1;
    else if (room == rmBossFrog)
        myCam.freeCam = 1;
    
    if (room == rmMain)
        myCam.autoScroll = 0;
}
