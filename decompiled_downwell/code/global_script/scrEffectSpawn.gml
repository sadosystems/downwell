function scrEffectSpawn(arg0, arg1, arg2, arg3, arg4, arg5)
{
    myFx = instance_create(arg0, arg1, parentNoloopFx);
    myFx.sprite_index = arg2;
    myFx.image_speed = arg3;
    myFx.image_angle = arg4;
    myFx.depth = arg5;
}
