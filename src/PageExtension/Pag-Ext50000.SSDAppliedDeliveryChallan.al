PageExtension 50000 "SSD Applied Delivery Challan" extends "Applied Delivery Challan"
{
    layout
    {
        addfirst(Control1)
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document No. field.';
            }
            field("Document Line No."; Rec."Document Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Line No. field.';
            }
        }
        addafter("Applied Delivery Challan No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line No. field.';
            }
        }
        addafter("Qty. to Receive")
        {
            field("SubCon Qty."; Rec."SSD SubCon Qty.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SubCon Qty. field.';
            }
        }
    }
}
