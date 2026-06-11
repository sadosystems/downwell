if (!global.languageJp)
{
    npcDialogue = "Your max combo#is " + string(global.highCombo) + " combo";
    
    if (global.highCombo > 1)
        npcDialogue += "s!";
    else
        npcDialogue += "!";
    
    npcDialogue += ("\\you have collected#a total of#" + string(global.totalGems) + " gems!");
    
    if (global.totalGems >= 10000)
        npcDialogue += "\\That's a lotta#gems!!!";
}
else
{
    npcDialogue = "あなたの#さいだいコンボすう は " + string(global.highCombo) + " で";
    npcDialogue += ("\\いままでで ごうけい#" + string(global.totalGems) + "こ ジェムを#あつめたよ！");
    
    if (global.totalGems >= 10000)
        npcDialogue += "\\めちゃ あつめたねー！";
}
