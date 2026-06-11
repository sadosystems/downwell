function scrSmokefx(arg0, arg1, arg2, arg3)
{
    smx = arg0;
    smy = arg1;
    smokenum = arg2;
    vary = arg3;
    smokenum += irandom_range(-vary, vary);
    
    repeat (smokenum)
        instance_create(smx + choose(-2, -1, 0, 1, 2), smy + choose(-2, -1, 0, 1, 2), fxSmoke);
}
