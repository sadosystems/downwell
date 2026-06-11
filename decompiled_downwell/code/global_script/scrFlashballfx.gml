function scrFlashballfx(arg0, arg1, arg2, arg3, arg4)
{
    smx = arg0;
    smy = arg1;
    smokenum = arg2;
    vary = arg3;
    pvary = arg4;
    smokenum += irandom_range(-vary, vary);
    
    repeat (smokenum)
        instance_create(smx + random_range(-pvary, pvary), smy + random_range(-pvary, pvary), fxFlashBall);
}
