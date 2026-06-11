function limboBreakSound(arg0)
{
    limboSndType = arg0;
    limbobSound = 225;
    
    if (limboSndType == UnknownEnum.Value_9)
        limboSndType = choose(UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_6, UnknownEnum.Value_7, UnknownEnum.Value_8);
    
    switch (limboSndType)
    {
        case UnknownEnum.Value_0:
            limbobSound = choose(225, 226, 227, 228, 229, 230, 231, 232, 233);
            break;
        
        case UnknownEnum.Value_1:
            limbobSound = choose(234, 235, 236, 237, 238, 239, 240, 241, 242);
            break;
        
        case UnknownEnum.Value_2:
            limbobSound = choose(243, 244, 245, 246);
            break;
        
        case UnknownEnum.Value_3:
            limbobSound = choose(252, 253, 254, 255, 256, 257, 258, 259, 260);
            break;
        
        case UnknownEnum.Value_4:
            limbobSound = choose(261, 262, 263, 264, 265, 266, 267, 268, 269);
            break;
        
        case UnknownEnum.Value_5:
            limbobSound = choose(270, 271, 272, 273, 274, 275, 276, 277, 278);
            break;
        
        case UnknownEnum.Value_6:
            limbobSound = choose(279, 280, 281, 282, 283, 284, 285, 286, 287);
            break;
        
        case UnknownEnum.Value_7:
            limbobSound = choose(288, 289, 290, 291, 292, 293, 294, 295, 296);
            break;
        
        case UnknownEnum.Value_8:
            limbobSound = choose(297, 298, 299, 300, 301, 302, 303, 304, 305);
            break;
    }
    
    soundPlay(limbobSound, 50, 0, 1);
    audio_sound_gain(sndsnd, 0.7, 0);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9
}
