function scrPDamage(arg0)
{
    dmgSourceName = object_get_name(object_index);
    
    if (global.ug[7][1])
        hitInvi = 240;
    else
        hitInvi = 90;
    
    if (!global.death)
    {
        if (!global.playerDamaged)
        {
            global.playerHp -= arg0;
            scrDmgCalcFxPlayer(arg0, point_direction(x, y, global.plx, global.ply));
            soundPlay(5, 90, 0, 0);
            bgmDuck(500, 0.7);
            global.pHit = 1;
            
            with (objControlerN)
            {
                room_speed = 40;
                slown = 23;
                alarm[0] = 40;
            }
        }
    }
    
    global.playerDamaged = 1;
    objPlayer_n.alarm[1] = hitInvi;
}
