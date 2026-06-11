function loadCheck()
{
    loadFor = global.area;
    
    switch (loadFor)
    {
        case 1:
            loadingGroup = 2;
            break;
        
        case 2:
            loadingGroup = 3;
            break;
        
        case 3:
            loadingGroup = 4;
            break;
        
        case 4:
            loadingGroup = 5;
            break;
        
        case 5:
            loadingGroup = 6;
            break;
    }
    
    if (!audio_group_is_loaded(loadingGroup))
        loadForArea(global.area);
}
