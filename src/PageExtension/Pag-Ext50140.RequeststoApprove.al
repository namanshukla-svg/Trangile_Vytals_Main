pageextension 50140 "Requests to Approve" extends "Requests to Approve"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.', Comment = '%';
            }
            field("Indent Order Type"; Rec."Indent Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Indent Order Type field.';
            }
        }
    }
}
