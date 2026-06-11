function scrRisingTextRed(arg0, arg1, arg2)
{
    if (room != rmTrailer)
    {
        basex = arg0;
        basey = arg1;
        drawText = arg2;
        myRisingText = instance_create(basex, basey, fxRisingTextRed);
        myRisingText.text = drawText;
    }
}
