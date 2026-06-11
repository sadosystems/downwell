function scrAimControl()
{
    if (global.dLeft)
    {
        aimAngle -= global.aimAngleAccl;
        
        if (aimAngle > 0)
            aimAngle -= global.aimAngleDccl;
    }
    
    if (global.dRight)
    {
        aimAngle += global.aimAngleAccl;
        
        if (aimAngle < 0)
            aimAngle += global.aimAngleDccl;
    }
    
    if (!(global.dLeft || global.dRight))
    {
        if (aimAngle != 0)
            aimAngle -= (sign(aimAngle) * global.aimAngleDccl);
        
        if (abs(aimAngle) < 2)
            aimAngle = 0;
    }
    
    if (abs(aimAngle) > global.aimAngleLimit)
        aimAngle = global.aimAngleLimit * sign(aimAngle);
}
