function stringAreaLevelRecord()
{
    rstr = "";
    rec = global.recordFurthestReached;
    
    if (rec >= 100)
    {
        rstr = "H ";
        rec -= 100;
    }
    
    switch (rec)
    {
        case 0:
            rstr += "0-0";
            break;
        
        case 11:
            rstr += "1-1";
            break;
        
        case 12:
            rstr += "1-2";
            break;
        
        case 13:
            rstr += "1-3";
            break;
        
        case 21:
            rstr += "2-1";
            break;
        
        case 22:
            rstr += "2-2";
            break;
        
        case 23:
            rstr += "2-3";
            break;
        
        case 31:
            rstr += "3-1";
            break;
        
        case 32:
            rstr += "3-2";
            break;
        
        case 33:
            rstr += "3-3";
            break;
        
        case 41:
            rstr += "4-1";
            break;
        
        case 42:
            rstr += "4-2";
            break;
        
        case 43:
            rstr += "4-3";
            break;
        
        case 51:
            rstr += "BOSS";
            break;
        
        case 90:
            rstr += "CLEARED";
            break;
    }
    
    return rstr;
}
