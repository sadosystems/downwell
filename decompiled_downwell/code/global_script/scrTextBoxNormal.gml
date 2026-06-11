function scrTextBoxNormal(arg0)
{
    myTextBox = instance_create(0, 0, TextBox);
    myTextBox.textString = arg0;
    myTextBox.returnToSender = id;
    
    with (myTextBox)
        textLength = string_length(textString);
}
