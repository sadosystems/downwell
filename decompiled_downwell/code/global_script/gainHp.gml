function gainHp(arg0)
{
    hpGain = arg0;
    soundPlay(3, 90, 0, 1);
    
    if ((global.playerHp + hpGain) <= global.playerHpMax)
    {
        global.playerHp += hpGain;
    }
    else if ((global.playerHp + hpGain) > global.playerHpMax)
    {
        maxDif = global.playerHpMax - global.playerHp;
        global.playerHp = global.playerHpMax;
        hpGain -= maxDif;
        
        for (global.heartPiece += hpGain; global.heartPiece >= global.heartPieceMax; global.heartPiece -= global.heartPieceMax)
        {
            global.playerHpMax += 1;
            global.playerHp = global.playerHpMax;
            scrRisingText(global.plx, global.ply - 8, "max HP up!");
        }
    }
}
