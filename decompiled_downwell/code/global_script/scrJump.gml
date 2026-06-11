function scrJump()
{
    if (!napping)
    {
        if (global.pugRocket)
        {
            myRocketBlast = instance_create(x, y + 4, bulletBlast);
            myRocketBlast.sprite_index = spSplosion1;
            soundPlay(344, 60, 0, 1);
            emitSmoke(global.plx, global.ply + 4, 15, 3);
            emitSmoke(global.plx, global.ply + 4, 165, 3);
        }
        
        if (!global.gInWater)
            ysp = -jumpsp;
        else
            ysp = -jumpspWater;
        
        jumped = 1;
        
        if (global.gInWater)
        {
            soundPlayOL(choose(313, 314), 80, 0, 1, "waterThings");
            
            repeat (2)
                instance_create(x, y, airBubbleMicro);
        }
        else
        {
            soundPlay(choose(86), 80, 0, 1);
            myJumpFx = instance_create(x, y, objJumpFx);
        }
        
        jumpShootLock = 1;
        grounded = 0;
        hardLandJump = 0;
        
        if (global.dLeft || global.dRight)
        {
            global.spinJumping = 1;
            
            if (global.ending)
                global.spinJumping = 0;
        }
        
        image_index = 0;
    }
}
