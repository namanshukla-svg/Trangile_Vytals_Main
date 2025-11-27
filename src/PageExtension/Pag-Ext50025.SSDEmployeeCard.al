pageextension 50025 "SSD Employee Card" extends "Employee Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Employee Dimension Code"; Rec."Employee Dimension Code")
            {
                ApplicationArea = All;
            }
            field("Employee Location"; Rec."Employee Location")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Business Segment"; Rec."Business Segment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Business Segment field.';
            }
        }
    }
}
