pageextension 50148 "SSD Item Location Matrix" extends "Items by Location Matrix"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies information in addition to the description.';
            }
        }
    }
}
