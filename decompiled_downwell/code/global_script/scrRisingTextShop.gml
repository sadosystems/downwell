function scrRisingTextShop(arg0, arg1, arg2)
{
    basex = arg0;
    basey = arg1;
    drawText = arg2;
    
    with (myRisingText)
        instance_destroy();
    
    myRisingText = instance_create(basex, basey, fxRisingText);
    myRisingText.text = drawText;
}
