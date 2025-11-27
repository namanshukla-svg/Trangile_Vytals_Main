PageExtension 50102 "SSD Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            Editable = true;
        }
        modify("Qty. to Receive")
        {
            Editable = true;
        }
        addafter(Description)
        {
            field("SSD Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Transfer Price")
        {
            field("Trf Price DUP. CSP"; Rec."Trf Price DUP. CSP")
            {
                ApplicationArea = All;
            }
            field("Amount DUP. CSP"; Rec."Amount DUP. CSP")
            {
                ApplicationArea = All;
            }
        }
        modify("Transfer-from Bin Code")
        {
            Visible = true;
        }
        modify("Transfer-To Bin Code")
        {
            Visible = true;
        }
    }
}
