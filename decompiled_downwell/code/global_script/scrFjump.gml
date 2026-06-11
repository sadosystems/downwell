function scrFjump(arg0, arg1)
{
    xfjump = arg0;
    yfjump = arg1;
    yfjumpdef = 2.7;
    
    if (yfjump == 0)
        yfjump = yfjumpdef;
    
    global.spinJumping = 1;
    scrRecharge();
    objPlayer_n.grounded = 0;
    
    if (xfjump != 0)
        objPlayer_n.xsp = xfjump;
    
    objPlayer_n.ysp = -yfjump;
}
