if (collision_rectangle(x - 32, y - 32, x + 32, y, objPlayer_n, 0, 0))
{
    if (!showText)
        showText = 1;
}
else if (showText)
{
    showText = 0;
    
    if (!answered)
    {
        if (global.languageJp)
            scrRisingTextJp(global.plx, global.ply, choose("うん", "はーい", "わかった！", "はい"));
        else
            scrRisingText(global.plx, global.ply, choose("OK!", "K", "YEP", "SURE"));
        
        answered = 1;
    }
}

if (global.plx > x)
    image_xscale = -1;
else
    image_xscale = 1;
