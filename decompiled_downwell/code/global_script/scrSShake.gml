function scrSShake(arg0, arg1)
{
    shakeAmt = arg0;
    shakeDur = arg1;
    camMain.camShake = 1;
    
    if (camMain.camShakeAmt < shakeAmt)
        camMain.camShakeAmt = shakeAmt;
    
    if (camMain.alarm[0] < shakeDur)
        camMain.alarm[0] = shakeDur;
}
