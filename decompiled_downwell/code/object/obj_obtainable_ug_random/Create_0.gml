event_inherited();
tries = 0;

while (true)
{
    whichUg = irandom(global.ugCount);
    
    if (global.ug[whichUg][1] < global.ug[whichUg][4])
        break;
    
    tries += 1;
    
    if (tries > 50)
    {
        whichUg = 100;
        break;
    }
}
