if (emitted < emitAmt)
{
    myAsc = instance_create(x, y, enmAscend);
    emitted += 1;
    alarm[0] = emitRate;
}
else
{
    instance_destroy();
}
