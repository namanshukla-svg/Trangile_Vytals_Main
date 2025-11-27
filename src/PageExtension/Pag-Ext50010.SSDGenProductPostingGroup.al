pageextension 50010 "SSD Gen. Product Posting Group" extends "Gen. Product Posting Groups"
{
    layout
    {
        addlast(content)
        {
            field("Critical Components"; Rec."Critical Components")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Critical Components field.';
            }
        }
    }
}
