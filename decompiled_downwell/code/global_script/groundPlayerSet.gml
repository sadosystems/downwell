function groundPlayerSet()
{
    if (room == rmMenu)
    {
        napRand = irandom(5);
        
        switch (napRand)
        {
            case 0:
                napSprite = 11;
                napImgSp = 0.015;
                napx = 112;
                napy = 506;
                napXscale = 1;
                break;
            
            case 1:
                napSprite = 12;
                napImgSp = 0.15;
                napx = 112;
                napy = 512;
                napXscale = 1;
                break;
            
            case 2:
                napSprite = 14;
                napImgSp = 0;
                napx = 290;
                napy = 496;
                napXscale = 1;
                break;
            
            case 3:
                napSprite = 13;
                napImgSp = 0;
                napx = 80;
                napy = 512;
                napXscale = 1;
                break;
            
            case 4:
                napSprite = 15;
                napImgSp = 0.25;
                napx = 295;
                napy = 496;
                napXscale = 1;
                break;
            
            case 5:
                napSprite = 14;
                napImgSp = 0;
                napx = 290;
                napy = 496;
                napXscale = 1;
                break;
        }
    }
    else if (room == rmGroundRuin)
    {
        napRand = irandom(3);
        
        switch (napRand)
        {
            case 0:
                napSprite = 15;
                napImgSp = 0.25;
                napx = 96;
                napy = 424;
                napXscale = 1;
                break;
            
            case 1:
                napSprite = 16;
                napImgSp = 0.25;
                napx = 89;
                napy = 464;
                napXscale = 1;
                break;
            
            case 2:
                napSprite = 12;
                napImgSp = 0.15;
                napx = 88;
                napy = 485;
                napXscale = 1;
                break;
            
            case 3:
                napSprite = 15;
                napImgSp = 0.25;
                napx = 295;
                napy = 496;
                napXscale = 1;
                break;
        }
    }
    else if (room == rmGroundGrave)
    {
        napRand = irandom(2);
        
        switch (napRand)
        {
            case 0:
                napSprite = 17;
                napImgSp = 0.25;
                napx = 96;
                napy = 512;
                napXscale = 1;
                break;
            
            case 1:
                napSprite = 13;
                napImgSp = 0.25;
                napx = 92;
                napy = 512;
                napXscale = 1;
                break;
            
            case 2:
                napSprite = 14;
                napImgSp = 0;
                napx = 290;
                napy = 496;
                napXscale = 1;
                break;
        }
    }
    else if (room == rmGroundMeteor)
    {
        napRand = irandom(2);
        
        switch (napRand)
        {
            case 0:
                napSprite = 15;
                napImgSp = 0.25;
                napx = 184;
                napy = 440;
                napXscale = 1;
                break;
            
            case 1:
                napSprite = 18;
                napImgSp = 0.25;
                napx = 131;
                napy = 480;
                napXscale = 1;
                break;
            
            case 2:
                napSprite = 18;
                napImgSp = 0.25;
                napx = 390;
                napy = 496;
                napXscale = -1;
                break;
        }
    }
    else if (room == rmGroundDouble)
    {
        napRand = 0;
        
        switch (napRand)
        {
            case 0:
                napSprite = 19;
                napImgSp = 0.3;
                napx = 130;
                napy = 520;
                napXscale = 1;
                break;
        }
    }
}
