function emitMovingFx(arg0, arg1, arg2, arg3, arg4, arg5)
{
    myFx = instance_create(arg0, arg1, parentMovingFx);
    myFx.sprite_index = arg2;
    myFx.image_speed = arg3;
    myFx.image_angle = arg4;
    myFx.xsp = lengthdir_x(arg5, arg4);
    myFx.ysp = lengthdir_y(arg5, arg4);
}
