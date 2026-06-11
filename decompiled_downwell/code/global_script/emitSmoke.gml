function emitSmoke(arg0, arg1, arg2, arg3)
{
    mySmoke = instance_create(arg0, arg1, fxSmoke);
    mySmoke.smokedir = arg2;
    mySmoke.smokesp = arg3;
}
