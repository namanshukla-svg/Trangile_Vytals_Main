pageextension 50127 "SSD Item Lookup" extends "Item Lookup"
{
    layout
    {
        modify("Item Category Code")
        {
            Visible = true;
        }
        addafter(Description)
        {
            field("SSD Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies information in addition to the description.';
            }
        }
    }
}
