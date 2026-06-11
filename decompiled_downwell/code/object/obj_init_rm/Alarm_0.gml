global.showSplash += 1;
alarm[0] = splashSpeed;

if (global.showSplash == 4)
    alarm[0] = 240;

if (global.showSplash >= 5)
    alarm[0] = 60;
