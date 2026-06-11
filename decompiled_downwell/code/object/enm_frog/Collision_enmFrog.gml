if (id < other.id)
{
    if (grounded)
    {
        rndm = 1;
        ysp = -jumpsp * rndm;
        rndm = 1;
        xsp = nsp * rndm;
        soundPlayOL(116, 50, 0, 1, "enemymove");
    }
    
    prepare = 0;
    alarm[1] = 90;
}
