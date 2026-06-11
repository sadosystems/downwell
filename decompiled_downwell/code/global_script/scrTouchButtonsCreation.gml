function scrTouchButtonsCreation()
{
    uppressed = 0;
    leftPressed = 0;
    rightPressed = 0;
    upHeldPressed = 0;
    upPressed = 0;
    upReleased = 0;
    leftEnd = 47;
    rightEnd = 47;
    betweenRightAndUp = 0;
    hbs = 56;
    ubs = 40;
    vtop = 160;
    vbottom = 345;
    pauseTapGap = 16;
    spriteLeft = 385;
    spriteRight = 387;
    spriteJump = 389;
    
    if (global.isTablet)
    {
        if (global.tabletOrientation == 0)
        {
            leftEnd = -78;
            rightEnd = 64;
            hbs = 32;
            ubs = 32;
            betweenRightAndUp = 204 - leftEnd - rightEnd;
            vtop = 160;
            vbottom = 250;
            pauseTapGap = 48;
            leftButtonx = -108;
            rightButtonx = leftEnd + 2;
            upButtonx = 216;
            buttonsy = 222;
            spriteLeft = 386;
            spriteRight = 388;
            spriteJump = 391;
        }
        
        if (global.tabletOrientation == 1)
        {
            leftEnd = 8;
            rightEnd = 64;
            hbs = 32;
            ubs = 32;
            betweenRightAndUp = 48;
            vtop = 160;
            vbottom = 265;
            pauseTapGap = 48;
            leftButtonx = -22;
            rightButtonx = leftEnd + 2;
            upButtonx = 146;
            buttonsy = 250;
            spriteLeft = 386;
            spriteRight = 388;
            spriteJump = 390;
        }
    }
    
    upFinger = -1;
    rightFinger = -1;
    dtpx = -1;
    dtd = 0;
    dtpxResetTimerCount = 0;
    dtpxResetTimer = 6;
    global.playerSprite = 0;
    playerImage = 0;
    playerXscale = 0;
}
