function scrGlobalStuff()
{
    global.tabletOrientation = 0;
    global.masterGain = 0.5;
    global.gameVolume = 1;
    global.hardSpikeActivate = 0;
    global.voidWind = -1;
    global.fightStarted = 0;
    global.easter = 1;
    global.achNoDamage = 1;
    global.achNoLand = 1;
    global.achNoSideroom = 1;
    global.achNoKill = 1;
    global.achNoShot = 1;
    global.newline = "\r";
    global.ugtgx = 32;
    global.ugtgy = 32;
    global.toggleGuncut = 1;
    global.deathMenuShow = 0;
    global.hardMode = -1;
    global.hardUnlocked = 0;
    global.globalAmbience = 0;
    global.noShot = 0;
    global.gameTime = 0;
    global.showTimer = -1;
    global.bossDead = 0;
    global.ending = 0;
    global.playStyle = 0;
    global.comboMilestone[0] = 8;
    global.comboMilestone[1] = 15;
    global.comboMilestone[2] = 25;
    global.killCount = 0;
    global.spikeDmg = 1;
    global.wrapMode = 0;
    global.gameGem = 0;
    global.noBgm = -1;
    global.shaderType = 0;
    global.gemHigh = 0;
    global.glitchMode = -1;
    
    if (os_type == os_windows)
        global.touchButtonShow = -1;
    else
        global.touchButtonShow = 1;
    
    global.gCircle = 0;
    global.gCirx = 0;
    global.gCiry = 0;
    global.totalGems = 0;
    global.highCombo = 0;
}
