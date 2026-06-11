if (!freeCam)
{
    if (!global.death)
    {
        if (global.plx < 160)
        {
            if (memorizey != 0)
                memorizey = 0;
            
            camPointx = 80;
            i = 3;
            
            if (chasePlayer)
                camPointy = global.ply;
            
            if (xx == 80)
                camSlowdown = 5;
            else
                camSlowdown = 1;
        }
        else
        {
            if (!memorizey)
                memorizey = global.ply;
            
            camPointy = memorizey - 104;
            camPointx = 240;
            
            if (xx != 240)
                camSlowdown = 1;
            else
                camSlowdown = 3;
        }
    }
    else if (global.plx < 160)
    {
        if (!memorizey)
            memorizey = global.ply;
        
        camPointy = memorizey;
        camPointx = 80;
    }
    else
    {
        if (!memorizey)
            memorizey = global.ply;
        
        camPointy = memorizey - 104;
        camPointx = 240;
        
        if (xx != 240)
            camSlowdown = 1;
        else
            camSlowdown = 1;
    }
}
else
{
    camPointx = global.plx;
    
    if (global.ply > 464)
        camPointy = 464;
    else if (global.ply < 160)
        camPointy = 160;
    else
        camPointy = global.ply;
}

if (!freeCam)
{
    camAcclx = (camPointx - xx) / camSlowdownX;
    camAccly = ((camPointy + (16 * daop)) - yy) / camSlowdown;
}
else
{
    camAcclx = (camPointx - xx) / camSlowdownX;
    camAccly = (camPointy - yy) / camSlowdown;
}

yy += camAccly;
xx += camAcclx;
x = round(xx);
y = round(yy);
