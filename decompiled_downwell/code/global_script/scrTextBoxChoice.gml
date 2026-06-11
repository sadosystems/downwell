function scrTextBoxChoice(arg0, arg1, arg2, arg3, arg4)
{
    myTextBox = instance_create(0, 0, TextBoxChoice);
    myTextBox.textString = arg0;
    myTextBox.choiceOption[0] = arg1;
    myTextBox.choiceOption[1] = arg2;
    myTextBox.decisionNumber = arg3;
    
    if (arg4 != 0)
        myTextBox.returnToSender = arg4;
    else
        myTextBox.returnToSender = id;
    
    with (myTextBox)
        textLength = string_length(textString);
}
