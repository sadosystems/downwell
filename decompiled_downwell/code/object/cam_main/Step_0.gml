if (!global.death)
{
    if (!freeCam)
    {
        if (global.plx > 160 && global.plx < (roomw - 160))
        {
            if (memorizey != 0)
                memorizey = 0;
            
            camPointx = global.plx + (global.plxDir * xAhead);
            
            if (camPointx < 240)
                camPointx = 240;
            else if (camPointx > (roomw - 160 - 80))
                camPointx = roomw - 160 - 80;
            
            if (autoScroll)
            {
                if (camPointy < (global.ply + daop))
                {
                    chasePlayer = 1;
                }
                else if (!global.pTimeStop)
                {
                    chasePlayer = 0;
                    camPointy += 0.5;
                }
            }
            
            if (chasePlayer)
                camPointy = global.ply + daop;
            
            if (xx > 160 && xx < (roomw - 160))
            {
                camSlowdown = 5;
                camSlowdownX = 10;
            }
            else
            {
                camSlowdown = 1;
                camSlowdownX = 1;
            }
        }
        else
        {
            camSlowdownX = 1;
            
            if (global.plx < 160)
                camPointx = 80;
            else if (global.plx > (roomw - 160))
                camPointx = roomw - 80;
        }
    }
    else if (freeCam)
    {
        if (memorizey != 0)
            memorizey = 0;
        
        camPointx = global.plx + (global.plxDir * xAhead);
        
        if (camPointx < 80)
            camPointx = 80;
        else if (camPointx > (roomw - 80))
            camPointx = roomw - 80;
        
        if (chasePlayer)
            camPointy = global.ply + daop;
        
        camSlowdown = 5;
        camSlowdownX = 10;
    }
}

if (centered && xAhead)
    xAhead = 0;
else if (!centered && !xAhead)
    xAhead = 16;

if (centered && objPlayer_n.xsp != 0)
{
    centered = 0;
    xAhead = 16;
}

if (sideLocked)
{
    if (!place_meeting(x, y, sideCamLocker))
    {
        camPointy = global.ply + daop;
        yy = camPointy;
        y = camPointy;
        camSlowdown = 1;
        camPointx = global.plx + (global.plxDir * 16);
        
        if (camPointx < 240)
            camPointx = 240;
        else if (camPointx > (roomw - 160 - 80))
            camPointx = roomw - 160 - 80;
        
        xx = camPointx;
        x = camPointx;
        camSlowdownX = 1;
        sideLocked = 0;
    }
}

if (global.pCamFocus)
{
    camPointy = global.pCamFocus.pointery;
    camPointx = global.pCamFocus.pointerx;
    camSlowdownX = 15;
}

if (roomEnd)
{
    if (camPointy > roomEnd)
    {
        camPointy = roomEnd;
        
        if (yy > roomEnd)
            yy = roomEnd;
    }
}

if (endingCamera == 1)
{
    if (daop > -200)
    {
        daop -= 0.5;
    }
    else if (!creditSpawn)
    {
        global.noControl = 1;
        creditSpawn = 1;
        objPlayer_n.xx = 240;
    }
}
else if (endingCamera == 2)
{
    if (daop < 24)
    {
        daop += 0.5;
    }
    else
    {
        daop = 24;
        endingCamera = 3;
        global.noControl = 0;
    }
}

camAcclx = (camPointx - xx) / camSlowdownX;
camAccly = (camPointy - yy) / camSlowdown;
yy += camAccly;
xx += camAcclx;

if (yy < 142)
    yy = 142;

xxFinal = xx;
yyFinal = yy;

if (camShake)
{
    xxFinal = xx + irandom_range(-camShakeAmt / 2, camShakeAmt / 2);
    yyFinal = yy + irandom_range(-camShakeAmt, camShakeAmt);
}

if (!global.ending)
{
    x = round(xxFinal);
    y = round(yyFinal);
}
