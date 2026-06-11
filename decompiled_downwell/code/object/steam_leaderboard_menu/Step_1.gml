if (powan < powanMax)
    powan += 0.4;

wholePowan -= sign(wholePowan);
wholePowan2 -= sign(wholePowan2);
powanx -= sign(powanx);

if (global.dRightPressed)
{
    showingBoard += 1;
    boardUpdate = 1;
    powan = 0;
    powanx = 1;
    soundPlayOL(324, 90, 0, 1, "UI");
}

if (global.dLeftPressed)
{
    showingBoard -= 1;
    boardUpdate = 1;
    powan = 0;
    powanx = 1;
    soundPlayOL(324, 90, 0, 1, "UI");
}

if (showingBoard > boardNum)
    showingBoard = 0;

if (showingBoard < 0)
    showingBoard = boardNum;

if (boardUpdate)
{
    for (i = 0; i <= 10; i += 1)
    {
        steam_name[i] = "-";
        steam_score[i] = 0;
        steam_rank[i] = "-";
    }
    
    switch (showingBoard)
    {
        case 0:
            score_get = steam_download_scores("HIGHEST GEM COUNT IN A RUN", 1, 8);
            break;
        
        case 1:
            score_get = steam_download_scores_around_user("HIGHEST GEM COUNT IN A RUN", -5, 2);
            break;
        
        case 2:
            score_get = steam_download_scores("LONGEST COMBO", 1, 8);
            break;
        
        case 3:
            score_get = steam_download_scores_around_user("LONGEST COMBO", -5, 2);
            break;
        
        case 4:
            score_get = steam_download_scores("FASTEST TIME", 1, 8);
            break;
        
        case 5:
            score_get = steam_download_scores_around_user("FASTEST TIME", -5, 2);
            break;
        
        case 6:
            score_get = steam_download_scores("FASTEST TIME HARD", 1, 8);
            break;
        
        case 7:
            score_get = steam_download_scores_around_user("FASTEST TIME HARD", -5, 2);
            break;
    }
    
    boardUpdate = 0;
}

if (global.dUp)
{
    with (instance_create(0, 0, RecordMenu))
        cursorAt = 0;
    
    instance_destroy();
    soundPlayOL(322, 90, 0, 1, "UI");
    global.padCancel = 0;
}

if (global.padCancel)
{
    with (instance_create(0, 0, RecordMenu))
        cursorAt = 0;
    
    instance_destroy();
    soundPlayOL(322, 90, 0, 1, "UI");
}

if (global.pauseInput || !global.isPaused)
{
    instance_destroy();
    
    if (!global.pTimeStop)
    {
        if (audio_is_paused(global.bgm))
            audio_resume_sound(global.bgm);
    }
}
