event_inherited();

if (global.plx > xx)
    image_xscale = -1;
else
    image_xscale = 1;

if (!speaking)
{
    if (place_meeting(xx, yy, objPlayer_n) && global.interactable)
    {
        if (global.dUp)
        {
            npcDialogue = "(debug purposes)#teleport to area " + string(teleportTo) + "?";
            speaking = 1;
            global.noControl = 1;
            
            if (global.plx > xx)
                objPlayer_n.image_xscale = -1;
            else
                objPlayer_n.image_xscale = 1;
            
            scrTextBoxChoice(npcDialogue, answer[0], answer[1], 0, 0);
            speakTimer = 0;
        }
    }
}

if (speaking)
{
    if (choice[0] != -1)
    {
        if (choice[0] == 0)
        {
            global.noControl = 0;
            speaking = 0;
            scrNextLevel(teleportTo);
        }
        else
        {
            global.noControl = 0;
            speaking = 0;
        }
        
        choice[0] = -1;
    }
}
