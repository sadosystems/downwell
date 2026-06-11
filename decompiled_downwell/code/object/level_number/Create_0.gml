if (!global.hardMode)
    levelTxt = langString("area" + string(global.area)) + "-" + string(global.level);
else
    levelTxt = langString("area" + string(global.area)) + "-H" + string(global.level);

txtWidth = string_width(string_hash_to_newline(levelTxt));
txtLength = string_length(levelTxt);
txtShown = 1;

for (i = 1; i <= txtLength; i += 1)
{
    txtAt[i][0] = string_char_at(levelTxt, i);
    txtAt[i][1] = 0;
    txtAt[i][2] = -2;
}

txtApInterval = 4;
alarm[0] = txtApInterval;
txtExInterval = 4;
txtRemainTime = 120;
txtExit = 0;
