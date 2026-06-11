event_inherited();
image_speed = 0.1;
speaking = 0;
xx = x;
yy = y;
speakTimer = 0;
speakAt = 60;

if (!global.languageJp)
    npcDialogue = "Wow you're really\r\ngood at this game!\\\r\nUnfortunately\r\nthis is the end\r\nof the demo.\\\r\nThank you very\r\nmuch for playing!\\\r\nrestarting game...";
else
    npcDialogue = "ここまで これるなんて すごい！\\\r\nたいけんばんは ここまでです\\\r\nプレイしてくれて ありがとう！\\\r\nリセットします...";

textOver = 0;
checkThis = 0;
