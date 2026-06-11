function steamAchGet(arg0)
{
    show_debug_message("achievement got: " + string(global.achievementNames[arg0]));
    
    if (global.isPC)
    {
        if (!global.steamApi)
        {
            if (steam_initialised())
            {
                if (steam_stats_ready())
                    global.steamApi = 1;
            }
        }
        
        if (global.steamApi)
        {
            var name = global.achievementNames[arg0];
            
            if (!steam_get_achievement(name))
                steam_set_achievement(name);
        }
    }
}
