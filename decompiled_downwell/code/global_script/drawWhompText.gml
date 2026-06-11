function drawWhompText(arg0, arg1, arg2, arg3, arg4)
{
    whompx = arg0;
    whompy = arg1;
    whompTxt = arg2;
    whompAmt = arg3;
    whompSp = arg4;
    time += whompSp;
    sineTime = abs(sin(time));
    draw_set_color(c_red);
    i = 0;
    
    for (i = 0; i <= whompAmt; i += 1)
        draw_text(whompx - round(sineTime * i), whompy - round(sineTime * i), string_hash_to_newline(whompTxt));
    
    draw_set_color(c_white);
    draw_text(whompx - round(sineTime * i), whompy - round(sineTime * i), string_hash_to_newline(whompTxt));
}
