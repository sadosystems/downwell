function scrShaderToggle()
{
    with (objControlerN)
    {
        global.shaderType += 1;
        
        if (global.shaderType > global.shaderArUnlocked)
            global.shaderType = 0;
        
        ini_open("save.ini");
        ini_write_real("stats", "shader", global.shaderType);
        ini_close();
    }
}
