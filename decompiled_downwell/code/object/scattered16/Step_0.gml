scrOutofview();

if (objHp <= 0 && active)
{
    scrCurrencySpawn(2);
    
    if (stomped)
        myGem.attracted = 1;
    
    repeat (2)
    {
        with (instance_create(x, y, breakablesDebris))
            ysp = -0.5;
    }
    
    breakSound = choose(171, 172, 173, 174);
    soundPlay(breakSound, 50, 0, 1);
    sprite_index = sprScatteredBreak;
    active = 0;
}
