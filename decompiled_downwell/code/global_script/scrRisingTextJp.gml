function scrRisingTextJp(arg0, arg1, arg2)
{
    if (room != rmTrailer)
    {
        basex = arg0;
        basey = arg1;
        drawText = arg2;
        myRisingText = instance_create(basex, basey, fxRisingTextJp);
        myRisingText.text = drawText;
    }
}
