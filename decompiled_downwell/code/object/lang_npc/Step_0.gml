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
            ini_open("save.ini");
            ini_write_real("stats", "jp", 0);
            ini_close();
        }
        else
        {
            ini_open("save.ini");
            ini_write_real("stats", "jp", 1);
            ini_close();
        }
        
        game_restart();
        choice[0] = -1;
    }
}
