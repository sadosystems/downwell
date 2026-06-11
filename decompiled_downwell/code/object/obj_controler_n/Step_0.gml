steam_update();

if (!global.inDebt)
{
    if (global.currency < 0)
        global.inDebt = 1;
    else if (global.currency >= 0)
        global.inDebt = 0;
}

if (global.ammo < 0)
    global.ammo = 0;
