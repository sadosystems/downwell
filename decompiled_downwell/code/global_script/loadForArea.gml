function loadForArea(arg0)
{
    if (audio_group_is_loaded(3))
        audio_group_unload(3);
    
    if (audio_group_is_loaded(4))
        audio_group_unload(4);
    
    if (audio_group_is_loaded(5))
        audio_group_unload(5);
    
    if (audio_group_is_loaded(6))
        audio_group_unload(6);
    
    loadFor = arg0;
    
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
    
    audio_group_load(loadingGroup);
    return loadingGroup;
}
