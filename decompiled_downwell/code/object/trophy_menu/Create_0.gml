menuTitleText = langString("menuTrophies");
powan = 0;
powanMax = 1;
wholePowan = 4;
wholePowan2 = 2;
displayedTrophy = 0;
trophyCount = 0;
var allTrophiesUnlocked = true;

for (var i = 0; i < UnknownEnum.Value_23; i++)
{
    trophyNameText[i] = langString("trophyName" + string(i));
    trophyDescText[i] = langString("trophyDesc" + string(i));
    
    if ((global.g_trophyUnlocked & (1 << i)) != 0)
    {
        trophyCount++;
        trophyUnlocked[i] = true;
    }
    else
    {
        trophyUnlocked[i] = false;
        allTrophiesUnlocked = false;
    }
}

trophyUnlocked[0] = allTrophiesUnlocked;
trophyCountString = "(" + string(trophyCount) + "/" + string(UnknownEnum.Value_23) + ")";
backText = langString("menuBack");

enum UnknownEnum
{
    Value_23 = 23
}
