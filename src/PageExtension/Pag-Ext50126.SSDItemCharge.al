pageextension 50126 "SSD Item Charge" extends "Item Charges"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description 2 field.';
            }
            field("Description 3"; Rec."Description 3")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description 3 field.';
            }
            field(UOM; Rec.UOM)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the UOM field.';
            }
        }
    }
}
