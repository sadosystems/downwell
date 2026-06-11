function scrDamageBox(arg0, arg1, arg2, arg3, arg4, arg5)
{
    dmgx = arg0;
    dmgy = arg1;
    myDmgBox = instance_create(dmgx, dmgy, objDamageBox);
    myDmgBox.boxDmg = arg2;
    myDmgBox.alarm[0] = arg3;
    myDmgBox.sprite_index = arg4;
    myDmgBox.image_xscale = arg5;
}
