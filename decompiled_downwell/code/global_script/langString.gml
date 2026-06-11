function langString(arg0)
{
    getString = arg0;
    ini_open("language.ini");
    returnString = ini_read_string(global.globalLanguage, getString, " ");
    ini_close();
    returnString = string_replace_all(returnString, "*", "#");
    return returnString;
}
