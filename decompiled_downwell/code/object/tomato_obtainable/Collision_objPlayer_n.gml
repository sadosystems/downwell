if (obtainable)
{
    gainHp(8);
    global.ammo += 10;
    global.stammo = global.ammo;
    
    if (global.isPC)
    {
        steam_create_leaderboard("TOMATO", lb_sort_descending, lb_disp_numeric);
        steam_upload_score("TOMATO", global.debugMode);
    }
    
    instance_destroy();
}
