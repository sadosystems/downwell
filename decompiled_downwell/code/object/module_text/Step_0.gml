if (!allSet)
{
    txtWidth = string_width(string_hash_to_newline(moduleTxt));
    txtLength = string_length(moduleTxt);
    txtShown = 1;
    
    for (i = 1; i <= txtLength; i += 1)
    {
        txtAt[i][0] = string_char_at(moduleTxt, i);
        txtAt[i][1] = 0;
        txtAt[i][2] = 0;
    }
    
    txtApInterval = 5;
    alarm[0] = txtApInterval;
    txtExInterval = 4;
    txtRemainTime = 120;
    txtExit = 0;
    allSet = 1;
}
