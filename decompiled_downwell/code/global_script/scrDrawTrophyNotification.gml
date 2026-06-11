function scrDrawTrophyNotification()
{
    with (objTrophy)
    {
        if (m_showingTrophy >= 0)
        {
            var trophyIcon = 23;
            var alarmCounter = alarm[0];
            
            if (alarmCounter < 120)
                trophyIcon = m_showingTrophy;
            
            var scale = 1;
            var vx = 80;
            var vy = 0;
            
            if (global.disp4x3)
            {
                vy = m_notificationY - 4;
                draw_sprite(sprTrophiesBorder, 0, vx, vy);
                draw_sprite(sprTrophies, trophyIcon, vx, vy);
            }
            else if (global.tateRotation == 1)
            {
                vy = m_notificationY - 4;
                draw_sprite(sprTrophiesBorder, 0, vx, vy);
                draw_sprite(sprTrophies, trophyIcon, vx, vy);
            }
            else if (global.tateRotation == 3)
            {
                scale = 1.775;
                vx = 338.1 - (m_notificationY * scale);
                vy = 142;
                draw_sprite_ext(sprTrophiesBorder, 0, vx, vy, scale, scale, -90, c_white, 1);
                draw_sprite_ext(sprTrophies, trophyIcon, vx, vy, scale, scale, -90, c_white, 1);
            }
            else
            {
                scale = 1.775;
                vx = (-0.1 + (m_notificationY * scale)) - 178;
                vy = 142;
                draw_sprite_ext(sprTrophiesBorder, 0, vx, vy, scale, scale, 90, c_white, 1);
                draw_sprite_ext(sprTrophies, trophyIcon, vx, vy, scale, scale, 90, c_white, 1);
            }
            
            if (alarmCounter < 126 && alarmCounter >= 120)
            {
                var frame = (125 - alarmCounter) + 24;
                draw_sprite_ext(sprTrophies, frame, vx, vy, scale, scale, 90, c_white, 1);
            }
            else if (alarmCounter < 120 && alarmCounter >= 114)
            {
                var frame = (alarmCounter - 114) + 24;
                draw_sprite_ext(sprTrophies, frame, vx, vy, scale, scale, 0, c_white, 1);
            }
        }
    }
}
