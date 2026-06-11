event_inherited();
xx = x;
yy = y;
thank = 0;
radio = -1;

if (global.area != 5)
{
    if (global.area != 3)
        radio = audio_play_sound(bgmShopCave, 100, 1);
    else
        radio = audio_play_sound(bgmShopAqua, 100, 1);
    
    audio_sound_gain(radio, 0, 0);
}

shopBgm = 0;
speaking = 0;
checkThis = 0;
tablex = xx + 64;
myTable = instance_create(tablex, y, shopTable);
glassCase[1] = instance_create(tablex - 19, y - 9, shopCase);
glassCase[2] = instance_create(tablex, y - 9, shopCase);
glassCase[3] = instance_create(tablex + 19, y - 9, shopCase);
myWall = instance_create(xx, yy + 8, objInvisWall);
keeper = instance_create(xx + 18, y, shopKeeper);
keeperx = keeper.x;
keeperAngry = 0;
shopInView = 0;
myRisingText = instance_create(-100, -100, fxRisingText);
exitShop = 0;
menuState = 0;
menuSelect = 0;
sellBtryPrice = 100;
b2hpPrice = 1;
b2hpAmt = 1;
sellBtryAmt = b2hpPrice;
cursorAt = 1;
cIndex = 0;
cSp = 0.25;
wfxy = 0;
wfxx = 0;
leave = 1;
choice[0] = -1;
active = 0;
myMsg = 0;
msgx = keeper.x + 2;
setPrice = 100 + (global.ugHave * 50);

for (i = 1; i <= 3; i += 1)
{
    saleUg[i][0] = 100;
    saleUg[i][1] = 1;
}

saleUg[1][0] = irandom_range(100, 101);

if (global.playerHp <= 2)
    saleUg[1][0] = 100;

saleUg[2][0] = irandom_range(100, 103);

while (saleUg[2][0] == saleUg[1][0])
    saleUg[2][0] = irandom_range(100, 103);

saleUg[3][0] = irandom_range(102, 105);

while (true)
{
    saleUg[3][0] = irandom_range(102, 105);
    
    if (saleUg[3][0] != saleUg[2][0])
    {
        if (saleUg[3][0] != saleUg[1][0])
            break;
    }
}

for (i = 1; i <= 3; i += 1)
{
    itemPrice[i] = global.ug[saleUg[i][0]][5];
    itemPrice[i] += 200 * (global.area - 1);
    
    if (global.hardMode)
        itemPrice[i] *= 2;
    
    if (global.playStyle == 4)
        itemPrice[i] -= round(itemPrice[i] / 10) * 3;
    
    if (global.pugMember)
        itemPrice[i] -= round(itemPrice[i] / 10);
    
    casedItem[i] = instance_create(glassCase[i].x, glassCase[i].y + 1, objObtainableUg);
    casedItem[i].whichUg = saleUg[i][0];
    glassCase[i].storedItem = 1;
}

scrShopAssignText();
