if (obtainable)
{
    soundPlay(28, 50, 0, 1);
    scrEffectSpawn(global.plx, global.ply, 111, 1, 0, -50500);
    global.pGunType = moduleNum;
    
    if (moduleType == 0)
    {
        global.ammo += 2;
        global.stammo = global.ammo;
        bStatUpdate(global.pGunType, global.pGunLevel);
        myModuleText = instance_create(x, y, moduleText);
        myModuleText.moduleTxt = global.pBulName;
        myModuleText.moduleType = moduleType;
        myModuleText.itemAmount = 2;
    }
    else if (moduleType == 1)
    {
        hpGain = 1;
        risingText = "+" + string(hpGain) + "HP#";
        
        if ((global.playerHp + hpGain) <= global.playerHpMax)
        {
            global.playerHp += hpGain;
        }
        else if ((global.playerHp + hpGain) > global.playerHpMax)
        {
            maxDif = global.playerHpMax - global.playerHp;
            global.playerHp = global.playerHpMax;
            hpGain -= maxDif;
            global.heartPiece += hpGain;
            
            if (global.heartPiece >= global.heartPieceMax)
            {
                global.playerHpMax += 1;
                global.playerHp = global.playerHpMax;
                risingText += "max HP up!";
                global.heartPiece -= global.heartPieceMax;
            }
            else
            {
                risingText += (string(global.heartPiece) + "/" + string(global.heartPieceMax));
            }
        }
        
        bStatUpdate(global.pGunType, global.pGunLevel);
        risingText = "##" + risingText;
        myModuleText = instance_create(x, y, moduleText);
        myModuleText.moduleTxt = global.pBulName;
        myModuleText.moduleType = moduleType;
        myModuleText.itemAmount = 1;
    }
    
    instance_destroy();
}
