function scrShopAssignText()
{
    for (i = 1; i <= 3; i += 1)
    {
        localItemName[i] = langString("ugName" + string(saleUg[i][0]));
        localItemDesc[i] = langString("ugDesc" + string(saleUg[i][0]));
    }
    
    txtExit = langString("shopExit");
    txtBuy = "BUY";
    txtSellbtry = "SELL#BTRY#";
    txtSell = "SELL";
    txtPurchase = langString("shopPurchased");
    txtBack = langString("menuBack");
    logMaido = langString("shopSold");
    logWelcome = langString("shopGreet0");
    logHello = langString("shopGreet1");
    logHoho = langString("shopGreet2");
    logThank = langString(choose("shopBye0", "shopBye1", "shopBye2"));
    logPoor = langString("shopPoor");
    logWhat = langString("shopWhat0");
    logHuh = langString("shopWhat1");
}
