function scrDeadBody(arg0, arg1, arg2)
{
    bodySpr = arg0;
    impactSp = arg1;
    
    if (impactSp > 4)
        impactSp = 4;
    
    myDeadBody = instance_create(x, y, objDeadBody);
    myDeadBody.sprite_index = bodySpr;
    myDeadBody.ysp = impactSp;
    myDeadBody.image_xscale = image_xscale;
    myDeadBody.explosionFx = arg2;
    
    if (abs(xsp) < 0.5)
        xsp = image_xscale * 1.5;
    
    if (impactSp != 0)
        myDeadBody.xsp = xsp * impactSp;
    else
        myDeadBody.xsp = sign(xsp) * 0.5;
}
