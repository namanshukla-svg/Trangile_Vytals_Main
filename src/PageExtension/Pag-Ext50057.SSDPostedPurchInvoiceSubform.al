PageExtension 50057 "SSD PostedPurchInvoiceSubform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("Line Discount Amount")
        {
            field("Receipt No."; Rec."Receipt No.")
            {
                ApplicationArea = All;
            }
            field("Receipt Line No."; Rec."Receipt Line No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Description 2")
        {
            Visible = true;
        }
        addafter("Description 2")
        {
            field("Description 3"; Rec."Description 3")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description 3 field.', Comment = '%';
            }
        }
    }
}
