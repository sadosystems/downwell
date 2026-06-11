function scrSmokefxAngle(arg0, arg1, arg2, arg3, arg4, arg5)
{
    smx = arg0;
    smy = arg1;
    smokenum = arg2;
    vary = arg3;
    smokenum += irandom_range(-vary, vary);
    smokeAngle = arg4;
    smokeAngleVary = arg5;
    
    repeat (smokenum)
    {
        mySmoke = instance_create(smx + choose(-2, -1, 0, 1, 2), smy + choose(-2, -1, 0, 1, 2), fxSmoke);
        angleRand = smokeAngle + (random(smokeAngleVary) * choose(1, -1));
        mySmoke.smokedir = angleRand;
    }
}
