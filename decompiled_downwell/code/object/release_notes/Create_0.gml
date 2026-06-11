event_inherited();
image_speed = 0.1;
speaking = 0;
xx = x;
yy = y;
speakTimer = 0;
speakAt = 60;
textOver = 0;

if (!global.languageJp)
    npcDialogue = "hear about changes?";
else
    npcDialogue = "へんこうてん きく?";

answer[0] = "yes";
answer[1] = "no";
npcDialogue2 = releasenoteText();
choice[0] = -1;
